package com.errorsmasher.es_viewer.es_viewer

import android.content.Intent
import android.net.Uri
import android.provider.OpenableColumns
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity: FlutterActivity() {
    private val channelName = "es_viewer/open_file"
    private var initialFilePath: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        initialFilePath = extractFilePathFromIntent(intent)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "consumeInitialFilePath" -> {
                        result.success(initialFilePath)
                        initialFilePath = null
                    }
                    else -> result.notImplemented()
                }
            }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        initialFilePath = extractFilePathFromIntent(intent)
    }

    private fun extractFilePathFromIntent(intent: Intent?): String? {
        if (intent == null) return null
        val action = intent.action ?: return null

        if (action == Intent.ACTION_VIEW) {
            val uri = intent.data
            return resolveUriToReadablePath(uri)
        }

        if (action == Intent.ACTION_SEND) {
            @Suppress("DEPRECATION")
            val uri = intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
            return resolveUriToReadablePath(uri)
        }
        return null
    }

    private fun resolveUriToReadablePath(uri: Uri?): String? {
        if (uri == null) return null
        if (uri.scheme == "file") {
            return uri.path
        }

        return try {
            val fileName = queryDisplayName(uri) ?: "shared_file"
            val target = File(cacheDir, "${System.currentTimeMillis()}_$fileName")
            contentResolver.openInputStream(uri)?.use { input ->
                target.outputStream().use { output ->
                    input.copyTo(output)
                }
            }
            if (target.exists()) target.absolutePath else null
        } catch (_: Exception) {
            null
        }
    }

    private fun queryDisplayName(uri: Uri): String? {
        return try {
            contentResolver.query(uri, null, null, null, null)?.use { cursor ->
                val nameIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                if (nameIndex >= 0 && cursor.moveToFirst()) {
                    cursor.getString(nameIndex)
                } else {
                    null
                }
            }
        } catch (_: Exception) {
            null
        }
    }
}

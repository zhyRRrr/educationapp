package live.hms.flutter

import android.content.res.Configuration
import android.os.Build
import live.hms.hmssdk_flutter.methods.HMSPipAction
import live.hms.hmssdk_flutter.Constants
import android.app.Activity
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    override fun onUserLeaveHint() {
        super.onUserLeaveHint()
        // This should only work for android version above 8 since PIP is only supported after
        // android 8 and will not be called after android 12 since it automatically gets handled by android.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O && Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            HMSPipAction.autoEnterPipMode(this)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == Constants.SCREEN_SHARE_INTENT_REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            data?.let {
                it.action = Constants.HMSSDK_RECEIVER
                sendBroadcast(it.putExtra(Constants.METHOD_CALL, Constants.SCREEN_SHARE_REQUEST))
            }
        }
    }
}

package com.we60devs.plugins;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.Manifest;
import android.os.Build;
import android.provider.MediaStore;
import android.database.Cursor;
import android.net.Uri;
import android.util.Log;

/**
 * This class echoes a string called from JavaScript.
 */
public class AudioLibrary extends CordovaPlugin  {

    private CallbackContext callbackContext = null;

    private String message;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("getItems")) {
            String message = args.getString(0);
            this.getItems(message, callbackContext);
            return true;
        }

        return false;
    }

    private void getItems(String message, CallbackContext callbackContext) {

        this.callbackContext = callbackContext;
        this.message = message;

        // Request permission during run-time
        if (Build.VERSION.SDK_INT >= 23) {
            if(!this.cordova.hasPermission(Manifest.permission.READ_EXTERNAL_STORAGE)) {
                this.cordova.requestPermission(this, 0, Manifest.permission.READ_EXTERNAL_STORAGE);
            } else {
                this.getList();
            }
        } else {
            this.getList();
        }
    }

    private void getList() {

        final String sortOrder = MediaStore.Audio.AudioColumns.TITLE + " COLLATE LOCALIZED ASC";

        Cursor cursor = null;
        String selection = MediaStore.Audio.Media.IS_MUSIC + "<>0";
        String[] projection = {
                MediaStore.Audio.Media.TITLE,
                MediaStore.Audio.Media.ARTIST,
                MediaStore.Audio.Media.DATA,
                MediaStore.Audio.Media.DURATION,
                MediaStore.Audio.Media._ID
        };

        JSONArray result = new JSONArray();

        try {
            Uri uri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI;
            cursor = this.cordova.getActivity().getContentResolver().query(uri, projection, selection, null, sortOrder);

            if (cursor != null) {
                cursor.moveToFirst();
                while (!cursor.isAfterLast()) {
                    if(cursor.getColumnCount() == 5) {
                        JSONObject item = new JSONObject();
                        item.put("title", cursor.getString(0));
                        item.put("artist", cursor.getString(1));
                        item.put("path", cursor.getString(2));
                        item.put("duration", cursor.getString(3));
                        item.put("_id", cursor.getString(4));
                        result.put(item);
                    }
                    cursor.moveToNext();
                }
            }
        } catch (Exception e) {
            this.callbackContext.error(e.toString());
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }

        this.callbackContext.success(result.toString());
    }

    public void onRequestPermissionResult(int requestCode, String[] permissions,
                                          int[] grantResults) throws JSONException
    {
        if(grantResults[0] == 0) {
            this.getItems(this.message, this.callbackContext);
        }
    }
}

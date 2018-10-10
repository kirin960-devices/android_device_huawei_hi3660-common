/*
* Copyright (C) 2016 The OmniROM Project
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*
*/
package org.lineageos.settings.device;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.res.Resources;
import android.content.Intent;
import android.os.Bundle;
import android.os.SystemProperties;
import android.support.v14.preference.PreferenceFragment;
import android.support.v7.preference.ListPreference;
import android.support.v7.preference.Preference;
import android.support.v7.preference.PreferenceCategory;
import android.support.v7.preference.PreferenceScreen;
import android.support.v7.preference.TwoStatePreference;
import android.provider.Settings;
import android.text.TextUtils;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import android.util.Log;

public class DeviceSettings extends PreferenceFragment implements
        Preference.OnPreferenceChangeListener {
    
    public static final String KEY_FP_GESTURES = "fp_gestures_key";
    public static String FPNAV_ENABLED_PROP = "sys.fpnav.enabled";
    
    public static final String KEY_HIGH_TOUCH = "high_touch_key";
    public static final String HIGH_TOUCH_MODE = "/sys/touchscreen/touch_glove";
    
    public static final String SLIDER_DEFAULT_VALUE = "4,2,0";
    
    private TwoStatePreference mFpGestures;
    private TwoStatePreference mHighTouch;

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        setPreferencesFromResource(R.xml.main, rootKey);

        mFpGestures = (TwoStatePreference) findPreference(KEY_FP_GESTURES);
        mFpGestures.setChecked(SystemProperties.get(FPNAV_ENABLED_PROP, "0").equals("1"));

        mHighTouch = (TwoStatePreference) findPreference(KEY_HIGH_TOUCH);
        mHighTouch.setChecked(Utils.getFileValueAsBoolean(HIGH_TOUCH_MODE, false));

    }

    @Override
    public boolean onPreferenceTreeClick(Preference preference) {
        if (preference == mFpGestures) {
        
            SystemProperties.set(FPNAV_ENABLED_PROP, mFpGestures.isChecked() ? "1" : "0");

            return true;
        }
        else if (preference == mHighTouch) {
            Utils.writeValue(HIGH_TOUCH_MODE, mHighTouch.isChecked() ? "1" : "0");
            return true;
        }
        return super.onPreferenceTreeClick(preference);
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue) {

        return true;
    }
}

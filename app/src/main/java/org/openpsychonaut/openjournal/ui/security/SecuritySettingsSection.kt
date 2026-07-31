/*
 * This file is part of OpenJournal (PsychonautWiki Journal).
 *
 * OpenJournal is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 *
 * PsychonautWiki Journal is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with PsychonautWiki Journal.  If not, see https://www.gnu.org/licenses/gpl-3.0.en.html.
 */

package org.openpsychonaut.openjournal.ui.security

import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Fingerprint
import androidx.compose.material.icons.outlined.Lock
import androidx.compose.material.icons.outlined.Pattern
import androidx.compose.material.icons.outlined.Pin
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import org.openpsychonaut.openjournal.ui.tabs.openjournal.experience.components.CardWithTitle
import org.openpsychonaut.openjournal.ui.tabs.settings.SettingsButton
import org.openpsychonaut.openjournal.ui.tabs.settings.combinations.UserPreferences

@Composable
fun SecuritySettingsSection(
    viewModel: SecurityViewModel = hiltViewModel()
) {
    val isAppLockEnabled by viewModel.isAppLockEnabledFlow.collectAsState()
    val lockType by viewModel.lockTypeFlow.collectAsState()
    val isBiometricEnabled by viewModel.isBiometricEnabledFlow.collectAsState()

    var showSetupDialog by remember { mutableStateOf<UserPreferences.LockType?>(null) }
    var setupStep by remember { mutableStateOf(1) } // 1: Enter, 2: Confirm
    var firstEntry by remember { mutableStateOf("") }

    CardWithTitle(title = "Security", innerPaddingHorizontal = 0.dp) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp, vertical = 8.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Column {
                Text(text = "App Lock")
                Text(
                    text = if (isAppLockEnabled) "Enabled (${lockType.name})" else "Disabled",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
            Switch(
                checked = isAppLockEnabled,
                onCheckedChange = { enabled ->
                    if (!enabled) {
                        // Logic to require current lock to disable
                        viewModel.setLock(UserPreferences.LockType.NONE, null)
                    } else {
                        showSetupDialog = UserPreferences.LockType.PIN
                    }
                }
            )
        }

        if (isAppLockEnabled) {
            HorizontalDivider()
            SettingsButton(
                imageVector = Icons.Outlined.Pin,
                text = "Change PIN"
            ) {
                showSetupDialog = UserPreferences.LockType.PIN
                setupStep = 1
            }
            HorizontalDivider()
            SettingsButton(
                imageVector = Icons.Outlined.Pattern,
                text = "Change Pattern"
            ) {
                showSetupDialog = UserPreferences.LockType.PATTERN
                setupStep = 1
            }
            HorizontalDivider()
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp, vertical = 8.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Icon(Icons.Outlined.Fingerprint, contentDescription = null)
                    Spacer(Modifier.width(12.dp))
                    Text(text = "Use Biometrics")
                }
                Switch(
                    checked = isBiometricEnabled,
                    onCheckedChange = viewModel::setBiometricEnabled
                )
            }
        }
    }

    // Setup Dialog
    if (showSetupDialog != null) {
        AlertDialog(
            onDismissRequest = { showSetupDialog = null },
            title = {
                Text(text = if (setupStep == 1) "Set ${showSetupDialog?.name}" else "Confirm ${showSetupDialog?.name}")
            },
            text = {
                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                    if (showSetupDialog == UserPreferences.LockType.PIN) {
                        var pinValue by remember { mutableStateOf("") }
                        OutlinedTextField(
                            value = pinValue,
                            onValueChange = { if (it.length <= 8) pinValue = it },
                            label = { Text("Enter 4-8 digits") },
                            modifier = Modifier.fillMaxWidth()
                        )
                        Spacer(modifier = Modifier.height(16.dp))
                        Button(onClick = {
                            if (setupStep == 1) {
                                firstEntry = pinValue
                                setupStep = 2
                                pinValue = ""
                            } else {
                                if (pinValue == firstEntry) {
                                    viewModel.setLock(UserPreferences.LockType.PIN, pinValue)
                                    showSetupDialog = null
                                } else {
                                    // Handle mismatch
                                    setupStep = 1
                                    pinValue = ""
                                }
                            }
                        }, enabled = pinValue.length >= 4) {
                            Text("Next")
                        }
                    } else if (showSetupDialog == UserPreferences.LockType.PATTERN) {
                        PatternLockView(onPatternComplete = { pattern ->
                            if (setupStep == 1) {
                                firstEntry = pattern
                                setupStep = 2
                            } else {
                                if (pattern == firstEntry) {
                                    viewModel.setLock(UserPreferences.LockType.PATTERN, pattern)
                                    showSetupDialog = null
                                } else {
                                    setupStep = 1
                                }
                            }
                        })
                    }
                }
            },
            confirmButton = {},
            dismissButton = {
                TextButton(onClick = { showSetupDialog = null }) {
                    Text("Cancel")
                }
            }
        )
    }
}

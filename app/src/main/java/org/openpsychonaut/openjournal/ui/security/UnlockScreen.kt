/*
 * This file is part of OpenJournal (PsychonautWiki Journal).
 *
 * OpenJournal is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at
 * your option) any later version.
 *
 * OpenJournal is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with PsychonautWiki Journal.  If not, see https://www.gnu.org/licenses/gpl-3.0.en.html.
 */

package org.openpsychonaut.openjournal.ui.security

import androidx.biometric.BiometricPrompt
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Fingerprint
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.unit.dp
import androidx.fragment.app.FragmentActivity
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import org.openpsychonaut.openjournal.ui.tabs.settings.combinations.UserPreferences
import kotlinx.coroutines.launch

@Composable
fun UnlockScreen(
    viewModel: SecurityViewModel = hiltViewModel(),
    onUnlockSuccess: () -> Unit
) {
    val lockType by viewModel.lockTypeFlow.collectAsState()
    val isBiometricEnabled by viewModel.isBiometricEnabledFlow.collectAsState()
    val scope = rememberCoroutineScope()
    val context = LocalContext.current

    var pinValue by remember { mutableStateOf("") }
    var errorMessage by remember { mutableStateOf<String?>(null) }

    val showBiometricPrompt = {
        val activity = context as? FragmentActivity
        if (activity != null && isBiometricEnabled) {
            val executor = androidx.core.content.ContextCompat.getMainExecutor(context)
            val biometricPrompt = BiometricPrompt(activity, executor,
                object : BiometricPrompt.AuthenticationCallback() {
                    override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                        super.onAuthenticationSucceeded(result)
                        onUnlockSuccess()
                    }
                })

            val promptInfo = BiometricPrompt.PromptInfo.Builder()
                .setTitle("Unlock OpenJournal")
                .setSubtitle("Use your biometric credential to unlock")
                .setNegativeButtonText("Use $lockType")
                .build()

            biometricPrompt.authenticate(promptInfo)
        }
    }

    LaunchedEffect(Unit) {
        if (isBiometricEnabled) {
            showBiometricPrompt()
        }
    }

    Surface(
        modifier = Modifier.fillMaxSize(),
        color = MaterialTheme.colorScheme.background
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(32.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Icon(
                imageVector = Icons.Default.Lock,
                contentDescription = null,
                modifier = Modifier.size(64.dp),
                tint = MaterialTheme.colorScheme.primary
            )
            Spacer(modifier = Modifier.height(24.dp))
            Text(
                text = "OpenJournal Locked",
                style = MaterialTheme.typography.headlineMedium,
                fontWeight = FontWeight.Bold
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "Please enter your ${lockType.name.lowercase()} to continue",
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )

            Spacer(modifier = Modifier.height(48.dp))

            when (lockType) {
                UserPreferences.LockType.PIN -> {
                    OutlinedTextField(
                        value = pinValue,
                        onValueChange = {
                            if (it.length <= 8) {
                                pinValue = it
                                errorMessage = null
                                if (it.length >= 4) {
                                    scope.launch {
                                        if (viewModel.verifyLockValue(it)) {
                                            onUnlockSuccess()
                                        } else if (it.length == 8) {
                                            errorMessage = "Incorrect PIN"
                                            pinValue = ""
                                        }
                                    }
                                }
                            }
                        },
                        label = { Text("Enter PIN") },
                        visualTransformation = PasswordVisualTransformation(),
                        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
                        singleLine = true,
                        isError = errorMessage != null,
                        modifier = Modifier.fillMaxWidth()
                    )
                    Button(
                        onClick = {
                            scope.launch {
                                if (viewModel.verifyLockValue(pinValue)) {
                                    onUnlockSuccess()
                                } else {
                                    errorMessage = "Incorrect PIN"
                                    pinValue = ""
                                }
                            }
                        },
                        enabled = pinValue.isNotEmpty(),
                        modifier = Modifier.padding(top = 16.dp)
                    ) {
                        Text("Unlock")
                    }
                }
                UserPreferences.LockType.PATTERN -> {
                    PatternLockView(
                        onPatternComplete = { pattern ->
                            scope.launch {
                                if (viewModel.verifyLockValue(pattern)) {
                                    onUnlockSuccess()
                                } else {
                                    errorMessage = "Incorrect Pattern"
                                }
                            }
                        }
                    )
                }
                else -> {
                    // Should not happen if locked
                    Button(onClick = onUnlockSuccess) {
                        Text("Unlock")
                    }
                }
            }

            errorMessage?.let {
                Text(
                    text = it,
                    color = MaterialTheme.colorScheme.error,
                    modifier = Modifier.padding(top = 16.dp)
                )
            }

            if (isBiometricEnabled) {
                IconButton(
                    onClick = showBiometricPrompt,
                    modifier = Modifier.padding(top = 32.dp)
                ) {
                    Icon(
                        imageVector = Icons.Default.Fingerprint,
                        contentDescription = "Biometric Unlock",
                        modifier = Modifier.size(48.dp),
                        tint = MaterialTheme.colorScheme.secondary
                    )
                }
            }
        }
    }
}

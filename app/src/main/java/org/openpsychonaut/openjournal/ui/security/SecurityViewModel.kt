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

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import org.openpsychonaut.openjournal.ui.tabs.settings.combinations.UserPreferences
import javax.inject.Inject

@HiltViewModel
class SecurityViewModel @Inject constructor(
    private val userPreferences: UserPreferences
) : ViewModel() {

    val isAppLockEnabledFlow: StateFlow<Boolean> = userPreferences.isAppLockEnabledFlow.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5000),
        initialValue = false
    )

    val lockTypeFlow: StateFlow<UserPreferences.LockType> = userPreferences.lockTypeFlow.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5000),
        initialValue = UserPreferences.LockType.NONE
    )

    val isBiometricEnabledFlow: StateFlow<Boolean> = userPreferences.isBiometricEnabledFlow.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5000),
        initialValue = false
    )

    var isLocked by mutableStateOf(false)
        private set

    init {
        viewModelScope.launch {
            isLocked = userPreferences.isAppLockEnabledFlow.first()
        }
    }

    fun unlock() {
        isLocked = false
    }

    fun lock() {
        viewModelScope.launch {
            if (userPreferences.isAppLockEnabledFlow.first()) {
                isLocked = true
            }
        }
    }

    suspend fun verifyLockValue(value: String): Boolean {
        val storedHash = userPreferences.lockValueFlow.first()
        val salt = userPreferences.lockSaltFlow.first()
        return if (storedHash == null || salt == null) {
            true // No lock set
        } else {
            SecurityUtils.verifyLockValue(value, salt, storedHash)
        }
    }

    fun setLock(type: UserPreferences.LockType, value: String?) {
        viewModelScope.launch {
            if (type == UserPreferences.LockType.NONE) {
                userPreferences.saveLockType(type)
                userPreferences.saveLockValue(null)
                userPreferences.saveLockSalt(null)
                userPreferences.saveAppLockEnabled(false)
                isLocked = false
            } else if (value != null) {
                val salt = SecurityUtils.generateSalt()
                val hash = SecurityUtils.hashLockValue(value, salt)
                userPreferences.saveLockType(type)
                userPreferences.saveLockValue(hash)
                userPreferences.saveLockSalt(salt)
                userPreferences.saveAppLockEnabled(true)
            }
        }
    }

    fun setBiometricEnabled(enabled: Boolean) {
        viewModelScope.launch {
            userPreferences.saveBiometricEnabled(enabled)
        }
    }
}

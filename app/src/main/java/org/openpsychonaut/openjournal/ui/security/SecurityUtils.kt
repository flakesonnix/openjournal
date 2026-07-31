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

import com.lambdapioneer.argon2kt.Argon2Kt
import com.lambdapioneer.argon2kt.Argon2Mode
import java.security.SecureRandom
import android.util.Base64

object SecurityUtils {
    private val argon2Kt = Argon2Kt()

    // Argon2id parameters
    private const val T_COST = 2
    private const val M_COST = 65536 // 64MB
    private const val PARALLELISM = 1

    fun generateSalt(): String {
        val salt = ByteArray(16)
        SecureRandom().nextBytes(salt)
        return Base64.encodeToString(salt, Base64.NO_WRAP)
    }

    fun hashLockValue(input: String, saltBase64: String): String {
        val salt = Base64.decode(saltBase64, Base64.NO_WRAP)
        val result = argon2Kt.hash(
            mode = Argon2Mode.ARGON2_ID,
            password = input.toByteArray(),
            salt = salt,
            tCostInIterations = T_COST,
            mCostInKibibyte = M_COST,
            parallelism = PARALLELISM
        )
        return result.encodedOutputAsString()
    }

    fun verifyLockValue(input: String, saltBase64: String, storedHash: String): Boolean {
        // Argon2Kt result.encodedOutputAsString() contains parameters and salt
        // But for simplicity and compatibility with our storage, we can use verify
        // or just re-hash and compare if we store the full encoded string.
        // The result.encodedOutputAsString() is actually a standard Argon2 string.
        return argon2Kt.verify(
            mode = Argon2Mode.ARGON2_ID,
            encoded = storedHash,
            password = input.toByteArray()
        )
    }
}

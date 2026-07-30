/*
 * Copyright (c) 2022. Isaak Hanimann.
 * This file is part of OpenJournal (PsychonautWiki Journal).
 *
 * PsychonautWiki Journal is free software: you can redistribute it and/or modify
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

package org.openpsychonaut.openjournal.data.substances.classes.roa

import kotlin.math.floor
import kotlin.math.roundToInt

data class RoaDose(
    val units: String,
    val lightMin: Double?,
    val commonMin: Double?,
    val strongMin: Double?,
    val heavyMin: Double?,
) {
    fun getDoseClass(ingestionDose: Double?, ingestionUnits: String? = units): DoseClass? {
        if (ingestionUnits != units || ingestionDose == null) return null
        return when {
            lightMin != null && ingestionDose < lightMin -> DoseClass.THRESHOLD
            commonMin != null && ingestionDose < commonMin -> DoseClass.LIGHT
            strongMin != null && ingestionDose < strongMin -> DoseClass.COMMON
            heavyMin != null && ingestionDose < heavyMin -> DoseClass.STRONG
            heavyMin != null -> DoseClass.HEAVY
            else -> null
        }
    }

    fun getNumDots(ingestionDose: Double?, ingestionUnits: String? = units): Int? {
        if (ingestionUnits != units || ingestionDose == null) return null
        
        return when {
            lightMin != null && ingestionDose < lightMin -> 0
            commonMin != null && ingestionDose < commonMin -> 1
            strongMin != null && ingestionDose < strongMin -> 2
            heavyMin != null && ingestionDose < heavyMin -> 3
            heavyMin != null -> {
                val timesHeavy = floor(ingestionDose / heavyMin).roundToInt()
                val rest = ingestionDose % heavyMin
                (timesHeavy * 4) + getNumDotsUpTo4(dose = rest)
            }
            strongMin != null -> 3
            commonMin != null -> 2
            lightMin != null -> 1
            else -> null
        }
    }

    private fun getNumDotsUpTo4(dose: Double): Int {
        return when {
            lightMin != null && dose < lightMin -> 0
            commonMin != null && dose < commonMin -> 1
            strongMin != null && dose < strongMin -> 2
            heavyMin != null && dose < heavyMin -> 3
            else -> 0
        }
    }

    val shouldUseVolumetricDosing: Boolean
        get() {
            if (units == "µg") return true
            return if (units == "mg") {
                val sample = commonMin ?: strongMin
                sample != null && sample < 15
            } else {
                false
            }
        }

    val averageCommonDose: Double? get() {
        return if (commonMin != null && strongMin != null) {
            (commonMin + strongMin) / 2
        } else {
            commonMin ?: strongMin
        }
    }

    fun getStrengthRelativeToCommonDose(dose: Double): Double? {
        return averageCommonDose?.let {
            if (it > 0.0000001) {
                dose / it
            } else {
                null
            }
        }
    }
}
/*
 * Copyright (c) 2022-2023. Isaak Hanimann.
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

package org.openpsychonaut.openjournal.ui.tabs.openjournal.addingestion.dose

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.navigation.toRoute
import org.openpsychonaut.openjournal.data.substances.AdministrationRoute
import org.openpsychonaut.openjournal.data.substances.classes.Substance
import org.openpsychonaut.openjournal.data.substances.classes.roa.DoseClass
import org.openpsychonaut.openjournal.data.substances.classes.roa.RoaDose
import org.openpsychonaut.openjournal.data.substances.repositories.SubstanceRepository
import org.openpsychonaut.openjournal.ui.main.navigation.graphs.ChooseDoseRoute
import org.openpsychonaut.openjournal.ui.tabs.search.substance.roa.toReadableString
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class ChooseDoseViewModel @Inject constructor(
    repository: SubstanceRepository,
    state: SavedStateHandle,
) : ViewModel() {
    private val chooseDoseRoute = state.toRoute<ChooseDoseRoute>()
    val substance: Substance = repository.getSubstance(chooseDoseRoute.substanceName)!!
    val administrationRoute: AdministrationRoute = chooseDoseRoute.administrationRoute
    val roaDose: RoaDose? = substance.getRoa(administrationRoute)?.roaDose
    var isEstimate by mutableStateOf(false)
    var doseText by mutableStateOf("")
    var estimatedDoseStandardDeviationText by mutableStateOf("")
    var purityText by mutableStateOf("100")
    var units by mutableStateOf("")
    private val purity: Double?
        get() {
            val p = purityText.toDoubleOrNull()
            return if (p != null && p > 0 && p <= 100) {
                p
            } else {
                null
            }
        }
    val isPurityValid: Boolean get() = purity != null
    val impureDoseWithUnit: String?
        get() {
            dose.let {
                if (it == null) return null
                purity.let { safePurity ->
                    if (safePurity == null) return null
                    val result = it.div(safePurity).times(100)
                    return result.toReadableString() + " impure ${roaDose?.units ?: ""}"
                }
            }
        }
    val dose: Double? get() = doseText.toDoubleOrNull()
    val estimatedDoseStandardDeviation: Double? get() = estimatedDoseStandardDeviationText.toDoubleOrNull()
    val isValidDose: Boolean get() = dose != null
    val currentDoseClass: DoseClass? get() = roaDose?.getDoseClass(ingestionDose = dose)

    fun onDoseTextChange(newDoseText: String) {
        doseText = newDoseText
    }

    fun onEstimatedDoseStandardDeviationChange(newEstimatedStandardDeviationText: String) {
        estimatedDoseStandardDeviationText = newEstimatedStandardDeviationText
    }

    init {
        units = roaDose?.units ?: ""
    }

}

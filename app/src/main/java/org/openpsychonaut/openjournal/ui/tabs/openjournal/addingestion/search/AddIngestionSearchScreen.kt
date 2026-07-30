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

package org.openpsychonaut.openjournal.ui.tabs.openjournal.addingestion.search

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Keyboard
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.outlined.Add
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.unit.dp
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import org.openpsychonaut.openjournal.data.room.experiences.entities.AdaptiveColor
import org.openpsychonaut.openjournal.data.room.experiences.entities.CustomSubstance
import org.openpsychonaut.openjournal.data.room.experiences.entities.CustomUnit
import org.openpsychonaut.openjournal.data.substances.AdministrationRoute
import org.openpsychonaut.openjournal.ui.tabs.openjournal.addingestion.search.suggestion.SuggestionRow
import org.openpsychonaut.openjournal.ui.tabs.openjournal.addingestion.search.suggestion.models.Suggestion
import org.openpsychonaut.openjournal.ui.tabs.search.SubstanceModel
import org.openpsychonaut.openjournal.ui.theme.horizontalPadding

@Composable
fun AddIngestionSearchScreen(
    navigateToCheckInteractions: (substanceName: String) -> Unit,
    navigateToCheckSaferUse: (substanceName: String) -> Unit,
    navigateToChooseRoute: (substanceName: String) -> Unit,
    navigateToDose: (substanceName: String, route: AdministrationRoute) -> Unit,
    navigateToChooseCustomSubstanceDose: (customSubstanceName: String, route: AdministrationRoute) -> Unit,
    navigateToChooseTime: (substanceName: String, route: AdministrationRoute, dose: Double?, units: String?, isEstimate: Boolean, estimatedDoseStandardDeviation: Double?, customUnitId: Int?) -> Unit,
    navigateToCustomSubstanceChooseRoute: (customSubstanceName: String) -> Unit,
    navigateToCustomUnitChooseDose: (customUnitId: Int) -> Unit,
    navigateToAddCustomSubstanceScreen: (searchText: String) -> Unit,
    viewModel: AddIngestionSearchViewModel = hiltViewModel()
) {
    val searchText = viewModel.searchTextFlow.collectAsState().value
    AddIngestionSearchScreen(
        navigateToCheckInteractions = navigateToCheckInteractions,
        navigateToCheckSaferUse = navigateToCheckSaferUse,
        navigateToChooseRoute = navigateToChooseRoute,
        navigateToCustomDose = navigateToChooseCustomSubstanceDose,
        navigateToCustomSubstanceChooseRoute = navigateToCustomSubstanceChooseRoute,
        navigateToChooseTime = navigateToChooseTime,
        navigateToDose = navigateToDose,
        navigateToAddCustomSubstanceScreen = {
            navigateToAddCustomSubstanceScreen(searchText)
        },
        navigateToCustomUnitChooseDose = navigateToCustomUnitChooseDose,
        suggestions = viewModel.filteredSuggestions.collectAsState().value,
        searchText = searchText,
        onChangeSearchText = {
            viewModel.updateSearchText(it)
        },
        filteredSubstances = viewModel.filteredSubstancesFlow.collectAsState().value,
        filteredCustomUnits = viewModel.filteredCustomUnitsFlow.collectAsState().value,
        filteredCustomSubstances = viewModel.filteredCustomSubstancesFlow.collectAsState().value
    )
}

@OptIn(ExperimentalMaterial3Api::class, ExperimentalFoundationApi::class)
@Composable
fun AddIngestionSearchScreen(
    navigateToCheckInteractions: (substanceName: String) -> Unit,
    navigateToChooseRoute: (substanceName: String) -> Unit,
    navigateToCheckSaferUse: (substanceName: String) -> Unit,
    navigateToDose: (substanceName: String, route: AdministrationRoute) -> Unit,
    navigateToCustomDose: (customSubstanceName: String, route: AdministrationRoute) -> Unit,
    navigateToChooseTime: (substanceName: String, route: AdministrationRoute, dose: Double?, units: String?, isEstimate: Boolean, estimatedDoseStandardDeviation: Double?, customUnitId: Int?) -> Unit,
    navigateToCustomSubstanceChooseRoute: (customSubstanceName: String) -> Unit,
    navigateToAddCustomSubstanceScreen: () -> Unit,
    navigateToCustomUnitChooseDose: (customUnitId: Int) -> Unit,
    suggestions: List<Suggestion>,
    searchText: String,
    onChangeSearchText: (searchText: String) -> Unit,
    filteredSubstances: List<SubstanceModel>,
    filteredCustomUnits: List<CustomUnit>,
    filteredCustomSubstances: List<CustomSubstance>
) {
    val focusRequester = remember { FocusRequester() }
    val focusManager = LocalFocusManager.current
    
    Scaffold(
        topBar = {
            Column(modifier = Modifier.background(MaterialTheme.colorScheme.surface)) {
                LinearProgressIndicator(
                    progress = { 0.17f },
                    modifier = Modifier.fillMaxWidth().clearAndSetSemantics { },
                )
                Spacer(modifier = Modifier.height(12.dp))
                OutlinedTextField(
                    value = searchText,
                    onValueChange = onChangeSearchText,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = 16.dp)
                        .focusRequester(focusRequester),
                    placeholder = { Text("Search substances") },
                    leadingIcon = { Icon(Icons.Default.Search, contentDescription = null) },
                    trailingIcon = {
                        if (searchText.isNotEmpty()) {
                            IconButton(onClick = { onChangeSearchText("") }) {
                                Icon(Icons.Default.Close, contentDescription = "Clear")
                            }
                        }
                    },
                    shape = RoundedCornerShape(28.dp),
                    colors = OutlinedTextFieldDefaults.colors(
                        focusedContainerColor = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.3f),
                        unfocusedContainerColor = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.3f),
                        unfocusedBorderColor = androidx.compose.ui.graphics.Color.Transparent,
                        focusedBorderColor = MaterialTheme.colorScheme.primary.copy(alpha = 0.5f)
                    ),
                    singleLine = true,
                    keyboardOptions = KeyboardOptions(
                        capitalization = KeyboardCapitalization.Words,
                        imeAction = ImeAction.Search
                    ),
                    keyboardActions = KeyboardActions(onSearch = { focusManager.clearFocus() })
                )
                Spacer(modifier = Modifier.height(8.dp))
            }
        },
        floatingActionButton = {
            FloatingActionButton(onClick = { focusRequester.requestFocus() }) {
                Icon(Icons.Default.Keyboard, contentDescription = "Keyboard")
            }
        }
    ) { padding ->
        Box(modifier = Modifier.padding(padding)) {
            SearchListContent(
                suggestions = suggestions,
                filteredSubstances = filteredSubstances,
                filteredCustomUnits = filteredCustomUnits,
                filteredCustomSubstances = filteredCustomSubstances,
                navigateToDose = navigateToDose,
                navigateToCustomUnitChooseDose = navigateToCustomUnitChooseDose,
                navigateToCustomDose = navigateToCustomDose,
                navigateToChooseTime = navigateToChooseTime,
                navigateToCustomSubstanceChooseRoute = navigateToCustomSubstanceChooseRoute,
                navigateToCheckSaferUse = navigateToCheckSaferUse,
                navigateToCheckInteractions = navigateToCheckInteractions,
                navigateToChooseRoute = navigateToChooseRoute,
                navigateToAddCustomSubstanceScreen = navigateToAddCustomSubstanceScreen
            )
        }
    }
}

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun SearchListContent(
    suggestions: List<Suggestion>,
    filteredSubstances: List<SubstanceModel>,
    filteredCustomUnits: List<CustomUnit>,
    filteredCustomSubstances: List<CustomSubstance>,
    navigateToDose: (substanceName: String, route: AdministrationRoute) -> Unit,
    navigateToCustomUnitChooseDose: (customUnitId: Int) -> Unit,
    navigateToCustomDose: (customSubstanceName: String, route: AdministrationRoute) -> Unit,
    navigateToChooseTime: (substanceName: String, route: AdministrationRoute, dose: Double?, units: String?, isEstimate: Boolean, estimatedDoseStandardDeviation: Double?, customUnitId: Int?) -> Unit,
    navigateToCustomSubstanceChooseRoute: (customSubstanceName: String) -> Unit,
    navigateToCheckSaferUse: (substanceName: String) -> Unit,
    navigateToCheckInteractions: (substanceName: String) -> Unit,
    navigateToChooseRoute: (substanceName: String) -> Unit,
    navigateToAddCustomSubstanceScreen: () -> Unit,
) {
    LazyColumn(modifier = Modifier.fillMaxSize()) {
        if (suggestions.isNotEmpty()) {
            stickyHeader {
                SectionHeader(title = "Quick logging")
            }
            itemsIndexed(suggestions) { index, suggestion ->
                SuggestionRow(
                    suggestion = suggestion,
                    navigateToDose = navigateToDose,
                    navigateToCustomUnitChooseDose = navigateToCustomUnitChooseDose,
                    navigateToCustomDose = navigateToCustomDose,
                    navigateToChooseTime = navigateToChooseTime
                )
                if (index < suggestions.size - 1) {
                    HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.5f))
                }
            }
        }
        if (filteredCustomSubstances.isNotEmpty()) {
            stickyHeader {
                SectionHeader(title = "Custom substances")
            }
            itemsIndexed(filteredCustomSubstances) { index, customSubstance ->
                SubstanceRowAddIngestion(substanceModel = SubstanceModel(
                    name = customSubstance.name,
                    commonNames = emptyList(),
                    categories = emptyList(),
                    hasSaferUse = false,
                    hasInteractions = false
                ), onTap = {
                    navigateToCustomSubstanceChooseRoute(customSubstance.name)
                })
                if (index < filteredCustomSubstances.size - 1) {
                    HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.5f))
                }
            }
        }
        if (filteredCustomUnits.isNotEmpty()) {
            stickyHeader {
                SectionHeader(title = "Custom units")
            }
            itemsIndexed(filteredCustomUnits) { index, customUnit ->
                CustomUnitRowAddIngestion(
                    customUnit = customUnit,
                    navigateToCustomUnitChooseDose = navigateToCustomUnitChooseDose)
                if (index < filteredCustomUnits.size - 1) {
                    HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.5f))
                }
            }
        }
        if (filteredSubstances.isNotEmpty()) {
            stickyHeader {
                SectionHeader(title = "Substances")
            }
            itemsIndexed(filteredSubstances) { index, substance ->
                SubstanceRowAddIngestion(substanceModel = substance, onTap = {
                    if (substance.hasSaferUse) {
                        navigateToCheckSaferUse(substance.name)
                    } else if (substance.hasInteractions) {
                        navigateToCheckInteractions(substance.name)
                    } else {
                        navigateToChooseRoute(substance.name)
                    }
                })
                if (index < filteredSubstances.size - 1) {
                    HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.5f))
                }
            }
        }
        item {
            Spacer(Modifier.height(16.dp))
            TextButton(
                onClick = navigateToAddCustomSubstanceScreen,
                modifier = Modifier.padding(horizontal = horizontalPadding)
            ) {
                Icon(
                    Icons.Outlined.Add, contentDescription = "Add"
                )
                Spacer(Modifier.size(ButtonDefaults.IconSpacing))
                Text(text = "Add custom substance")
            }
            Spacer(Modifier.height(80.dp))
        }
        item {
            if (filteredSubstances.isEmpty() && filteredCustomSubstances.isEmpty() && suggestions.isEmpty()) {
                Text("No matching substance found", modifier = Modifier.padding(horizontal = horizontalPadding, vertical = 24.dp))
            }
        }
    }
}

@Composable
fun SectionHeader(title: String) {
    Surface(
        color = MaterialTheme.colorScheme.surface,
        modifier = Modifier.fillMaxWidth()
    ) {
        Text(
            modifier = Modifier
                .padding(horizontal = horizontalPadding, vertical = 12.dp)
                .fillMaxWidth(),
            text = title,
            style = MaterialTheme.typography.titleSmall,
            color = MaterialTheme.colorScheme.primary,
            fontWeight = androidx.compose.ui.text.font.FontWeight.Bold
        )
    }
}


@Composable
fun ColorCircle(adaptiveColor: AdaptiveColor) {
    val isDarkTheme = isSystemInDarkTheme()
    Surface(
        shape = CircleShape,
        color = adaptiveColor.getComposeColor(isDarkTheme),
        modifier = Modifier.size(25.dp)
    ) {}
}

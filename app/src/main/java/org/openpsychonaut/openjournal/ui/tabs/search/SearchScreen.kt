/*
 * Copyright (c) 2023. Isaak Hanimann.
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

package org.openpsychonaut.openjournal.ui.tabs.search

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Keyboard
import androidx.compose.material.icons.outlined.Add
import androidx.compose.material.icons.outlined.Search
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExtendedFloatingActionButton
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.semantics.clearAndSetSemantics
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import org.openpsychonaut.openjournal.ui.tabs.search.substancerow.SubstanceRow
import org.openpsychonaut.openjournal.ui.theme.horizontalPadding

@Composable
fun SearchScreen(
    searchViewModel: SearchViewModel = hiltViewModel(),
    onSubstanceTap: (substanceModel: SubstanceModel) -> Unit,
    onCustomSubstanceTap: (customSubstanceId: Int) -> Unit,
    navigateToAddCustomSubstanceScreen: () -> Unit,
) {
    val focusRequester = remember { FocusRequester() }
    var isFocused by remember { mutableStateOf(false) }
    Scaffold(
        floatingActionButton = {
            if (!isFocused) {
                ExtendedFloatingActionButton(
                    onClick = navigateToAddCustomSubstanceScreen,
                    icon = { Icon(Icons.Default.Add, null) },
                    text = { Text("Custom") }
                )
            }
        },
    ) { padding ->
        Column(modifier = Modifier
            .fillMaxSize()
            .padding(padding)) {
            SearchField(
                modifier = Modifier
                    .fillMaxWidth()
                    .focusRequester(focusRequester)
                    .onFocusChanged { focusState ->
                        isFocused = focusState.isFocused
                    }
                    .clearAndSetSemantics { },
                searchText = searchViewModel.searchTextFlow.collectAsState().value,
                onChange = {
                    searchViewModel.filterSubstances(searchText = it)
                },
                categories = searchViewModel.chipCategoriesFlow.collectAsState().value,
                onFilterTapped = searchViewModel::onFilterTapped,
                isShowingFilter = true
            )
            val activeFilters =
                searchViewModel.chipCategoriesFlow.collectAsState().value.filter { it.isActive }
            val onFilterTapped = searchViewModel::onFilterTapped
            val filteredSubstances = searchViewModel.filteredSubstancesFlow.collectAsState().value
            val filteredCustomSubstances =
                searchViewModel.filteredCustomSubstancesFlow.collectAsState().value
            
            if (activeFilters.isNotEmpty()) {
                LazyRow(
                    horizontalArrangement = Arrangement.spacedBy(8.dp),
                    contentPadding = PaddingValues(horizontal = 16.dp),
                    modifier = Modifier.padding(vertical = 8.dp)
                ) {
                    items(activeFilters) { categoryChipModel ->
                        CategoryChipDelete(categoryChipModel = categoryChipModel) {
                            onFilterTapped(categoryChipModel.chipName)
                        }
                    }
                }
            }
            
            if (filteredSubstances.isEmpty() && filteredCustomSubstances.isEmpty()) {
                Box(
                    modifier = Modifier.fillMaxSize(),
                    contentAlignment = Alignment.Center
                ) {
                    Column(
                        horizontalAlignment = Alignment.CenterHorizontally,
                        modifier = Modifier.padding(32.dp)
                    ) {
                        Icon(
                            Icons.Outlined.Search,
                            contentDescription = null,
                            modifier = Modifier.size(64.dp),
                            tint = MaterialTheme.colorScheme.outlineVariant
                        )
                        Spacer(Modifier.height(16.dp))
                        Text(
                            text = "No substances found",
                            style = MaterialTheme.typography.titleMedium,
                            textAlign = TextAlign.Center
                        )
                        Text(
                            text = "Try adjusting your filters or search terms.",
                            style = MaterialTheme.typography.bodySmall,
                            textAlign = TextAlign.Center,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                        Spacer(Modifier.height(24.dp))
                        TextButton(onClick = navigateToAddCustomSubstanceScreen) {
                            Icon(Icons.Default.Add, null)
                            Spacer(Modifier.width(8.dp))
                            Text("Add Custom Substance")
                        }
                    }
                }
            } else {
                LazyColumn(
                    modifier = Modifier.fillMaxSize(),
                    contentPadding = PaddingValues(bottom = 80.dp)
                ) {
                    if (filteredCustomSubstances.isNotEmpty()) {
                        item {
                            Text(
                                "Your Substances",
                                style = MaterialTheme.typography.labelLarge,
                                color = MaterialTheme.colorScheme.primary,
                                modifier = Modifier.padding(start = 16.dp, top = 16.dp, bottom = 8.dp)
                            )
                        }
                        items(filteredCustomSubstances) { customSubstance ->
                            SubstanceRow(substanceModel = SubstanceModel(
                                name = customSubstance.name,
                                commonNames = emptyList(),
                                categories = listOf(
                                    CategoryModel(
                                        name = "Custom", color = customColor
                                    )
                                ),
                                hasSaferUse = false,
                                hasInteractions = false
                            ), onTap = {
                                onCustomSubstanceTap(customSubstance.id)
                            })
                        }
                        item { HorizontalDivider(modifier = Modifier.padding(vertical = 8.dp)) }
                    }

                    if (filteredSubstances.isNotEmpty()) {
                        item {
                            Text(
                                "Library",
                                style = MaterialTheme.typography.labelLarge,
                                color = MaterialTheme.colorScheme.secondary,
                                modifier = Modifier.padding(start = 16.dp, top = 16.dp, bottom = 8.dp)
                            )
                        }
                        items(filteredSubstances) { substance ->
                            SubstanceRow(substanceModel = substance, onTap = {
                                onSubstanceTap(substance)
                            })
                        }
                    }
                }
            }
        }
    }
}


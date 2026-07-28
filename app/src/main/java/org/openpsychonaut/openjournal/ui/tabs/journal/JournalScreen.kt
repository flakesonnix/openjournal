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

package org.openpsychonaut.openjournal.ui.tabs.journal

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
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
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.ArrowUpward
import androidx.compose.material.icons.filled.CalendarMonth
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Star
import androidx.compose.material.icons.filled.Timer
import androidx.compose.material.icons.outlined.SearchOff
import androidx.compose.material.icons.outlined.StarOutline
import androidx.compose.material.icons.outlined.Timer
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExtendedFloatingActionButton
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconToggleButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalFocusManager
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import androidx.compose.ui.unit.dp
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import org.openpsychonaut.openjournal.data.room.experiences.relations.ExperienceWithIngestionsCompanionsAndRatings
import org.openpsychonaut.openjournal.ui.tabs.journal.components.ExperienceRow
import org.openpsychonaut.openjournal.ui.tabs.stats.EmptyScreenDisclaimer
import org.openpsychonaut.openjournal.ui.theme.OpenJournalTheme
import org.openpsychonaut.openjournal.ui.theme.horizontalPadding
import kotlinx.coroutines.launch

@Composable
fun JournalScreen(
    navigateToExperiencePopNothing: (experienceId: Int) -> Unit,
    navigateToAddIngestion: () -> Unit,
    navigateToCalendar: () -> Unit,
    viewModel: JournalViewModel = hiltViewModel()
) {
    val activeExperiences by viewModel.activeExperiences.collectAsState()
    val pastExperiences by viewModel.pastExperiences.collectAsState()

    LaunchedEffect(Unit) {
        viewModel.maybeMigrate()
    }
    JournalScreen(
        navigateToExperiencePopNothing = navigateToExperiencePopNothing,
        navigateToAddIngestion = {
            viewModel.resetAddIngestionTimes()
            navigateToAddIngestion()
        },
        navigateToCalendar = navigateToCalendar,
        isFavoriteEnabled = viewModel.isFavoriteEnabledFlow.collectAsState().value,
        onChangeIsFavorite = viewModel::onChangeFavorite,
        isTimeRelativeToNow = viewModel.isTimeRelativeToNow.value,
        onChangeIsRelative = viewModel::onChangeRelative,
        searchText = viewModel.searchTextFlow.collectAsState().value,
        onChangeSearchText = viewModel::search,
        isSearchEnabled = viewModel.isSearchEnabled.value,
        onChangeIsSearchEnabled = viewModel::onChangeOfIsSearchEnabled,
        activeExperiences = activeExperiences,
        pastExperiences = pastExperiences,
    )
}

@Preview
@Composable
fun ExperiencesScreenPreview(
    @PreviewParameter(
        JournalScreenPreviewProvider::class,
    ) experiences: List<ExperienceWithIngestionsCompanionsAndRatings>,
) {
    OpenJournalTheme {
        JournalScreen(
            navigateToExperiencePopNothing = {},
            navigateToAddIngestion = {},
            navigateToCalendar = {},
            isFavoriteEnabled = false,
            onChangeIsFavorite = {},
            isTimeRelativeToNow = true,
            onChangeIsRelative = {},
            searchText = "",
            onChangeSearchText = {},
            isSearchEnabled = true,
            onChangeIsSearchEnabled = {},
            activeExperiences = experiences.take(1),
            pastExperiences = experiences.drop(1),
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun JournalScreen(
    navigateToExperiencePopNothing: (experienceId: Int) -> Unit,
    navigateToAddIngestion: () -> Unit,
    navigateToCalendar: () -> Unit,
    isFavoriteEnabled: Boolean,
    onChangeIsFavorite: (Boolean) -> Unit,
    isTimeRelativeToNow: Boolean,
    onChangeIsRelative: (Boolean) -> Unit,
    searchText: String,
    onChangeSearchText: (String) -> Unit,
    isSearchEnabled: Boolean,
    onChangeIsSearchEnabled: (Boolean) -> Unit,
    activeExperiences: List<ExperienceWithIngestionsCompanionsAndRatings>,
    pastExperiences: List<ExperienceWithIngestionsCompanionsAndRatings>,
) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    Column {
                        Text(
                            text = "OpenJournal",
                            style = MaterialTheme.typography.titleLarge,
                            fontWeight = FontWeight.ExtraBold
                        )
                    }
                },
                actions = {
                    IconToggleButton(
                        checked = isTimeRelativeToNow,
                        onCheckedChange = onChangeIsRelative
                    ) {
                        if (isTimeRelativeToNow) {
                            Icon(Icons.Filled.Timer, contentDescription = "Regular time")
                        } else {
                            Icon(Icons.Outlined.Timer, contentDescription = "Time relative to now")
                        }
                    }
                    IconToggleButton(
                        checked = isFavoriteEnabled,
                        onCheckedChange = onChangeIsFavorite
                    ) {
                        if (isFavoriteEnabled) {
                            Icon(Icons.Filled.Star, contentDescription = "Is favorite")
                        } else {
                            Icon(Icons.Outlined.StarOutline, contentDescription = "Is not favorite")
                        }
                    }
                    IconToggleButton(
                        checked = isSearchEnabled,
                        onCheckedChange = onChangeIsSearchEnabled
                    ) {
                        if (isSearchEnabled) {
                            Icon(Icons.Outlined.SearchOff, contentDescription = "Search off")
                        } else {
                            Icon(Icons.Filled.Search, contentDescription = "Search")
                        }
                    }
                    IconButton(onClick = navigateToCalendar) {
                        Icon(
                            Icons.Default.CalendarMonth,
                            contentDescription = "Navigate to calendar"
                        )
                    }
                }
            )
        },
        floatingActionButton = {
            if (!isSearchEnabled) {
                ExtendedFloatingActionButton(
                    onClick = navigateToAddIngestion,
                    containerColor = MaterialTheme.colorScheme.primaryContainer,
                    contentColor = MaterialTheme.colorScheme.onPrimaryContainer,
                    icon = {
                        Icon(
                            Icons.Filled.Add,
                            contentDescription = "Add"
                        )
                    },
                    text = { Text("Log Dose") },
                )
            }
        },
    ) { padding ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
        ) {
            val listState = rememberLazyListState()
            val isScrollUpButtonShown by remember {
                derivedStateOf {
                    listState.firstVisibleItemIndex > 0
                }
            }

            LazyColumn(
                modifier = Modifier.fillMaxSize(),
                state = listState,
                contentPadding = PaddingValues(bottom = 80.dp)
            ) {
                if (isSearchEnabled) {
                    item {
                        val focusManager = LocalFocusManager.current
                        TextField(
                            value = searchText,
                            onValueChange = onChangeSearchText,
                            leadingIcon = {
                                Icon(
                                    Icons.Default.Search,
                                    contentDescription = "Search",
                                )
                            },
                            trailingIcon = {
                                if (searchText != "") {
                                    IconButton(
                                        onClick = {
                                            onChangeSearchText("")
                                        }
                                    ) {
                                        Icon(
                                            Icons.Default.Close,
                                            contentDescription = "Close",
                                        )
                                    }
                                }
                            },
                            placeholder = { Text(text = "Search experiences...") },
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(horizontalPadding),
                            colors = TextFieldDefaults.colors(
                                focusedContainerColor = Color.Transparent,
                                unfocusedContainerColor = Color.Transparent,
                                disabledContainerColor = Color.Transparent,
                            ),
                            keyboardActions = KeyboardActions(onDone = { focusManager.clearFocus() }),
                            keyboardOptions = KeyboardOptions(
                                keyboardType = KeyboardType.Text,
                                capitalization = KeyboardCapitalization.Sentences
                            ),
                            singleLine = true
                        )
                    }
                }

                if (activeExperiences.isNotEmpty() && !isSearchEnabled) {
                    item {
                        Text(
                            text = "Ongoing Sessions",
                            style = MaterialTheme.typography.labelLarge,
                            color = MaterialTheme.colorScheme.primary,
                            modifier = Modifier.padding(
                                start = horizontalPadding,
                                top = 16.dp,
                                bottom = 8.dp
                            )
                        )
                    }
                    items(activeExperiences) { experienceWithIngestions ->
                        ExperienceRow(
                            experienceWithIngestions,
                            navigateToExperienceScreen = {
                                navigateToExperiencePopNothing(experienceWithIngestions.experience.id)
                            },
                            isTimeRelativeToNow = isTimeRelativeToNow
                        )
                    }
                    item {
                        Spacer(modifier = Modifier.height(8.dp))
                        HorizontalDivider(
                            modifier = Modifier.padding(horizontal = horizontalPadding),
                            thickness = 0.5.dp,
                            color = MaterialTheme.colorScheme.outlineVariant
                        )
                    }
                }

                if (pastExperiences.isNotEmpty() || (isSearchEnabled && activeExperiences.isEmpty())) {
                    if (!isSearchEnabled && activeExperiences.isNotEmpty()) {
                        item {
                            Text(
                                text = "History",
                                style = MaterialTheme.typography.labelLarge,
                                color = MaterialTheme.colorScheme.secondary,
                                modifier = Modifier.padding(
                                    start = horizontalPadding,
                                    top = 16.dp,
                                    bottom = 8.dp
                                )
                            )
                        }
                    }
                    items(pastExperiences) { experienceWithIngestions ->
                        ExperienceRow(
                            experienceWithIngestions,
                            navigateToExperienceScreen = {
                                navigateToExperiencePopNothing(experienceWithIngestions.experience.id)
                            },
                            isTimeRelativeToNow = isTimeRelativeToNow
                        )
                    }
                }

                if (activeExperiences.isEmpty() && pastExperiences.isEmpty()) {
                    item {
                        Box(
                            modifier = Modifier
                                .fillParentMaxSize()
                                .padding(32.dp),
                            contentAlignment = Alignment.Center
                        ) {
                            if (isSearchEnabled && searchText.isNotEmpty()) {
                                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                                    Text(
                                        text = "No results",
                                        style = MaterialTheme.typography.titleMedium
                                    )
                                    Text(
                                        text = "Nothing matches \"$searchText\"",
                                        style = MaterialTheme.typography.bodySmall,
                                        textAlign = TextAlign.Center
                                    )
                                }
                            } else if (!isSearchEnabled) {
                                EmptyScreenDisclaimer(
                                    title = if (isFavoriteEnabled) "No favorites" else "No experiences yet",
                                    description = if (isFavoriteEnabled) "Mark experiences as favorites to find them quickly." else "Add your first ingestion to start tracking."
                                )
                            }
                        }
                    }
                }
            }

            AnimatedVisibility(
                visible = isScrollUpButtonShown,
                enter = fadeIn(),
                exit = fadeOut(),
                modifier = Modifier
                    .align(Alignment.BottomEnd)
                    .padding(bottom = 16.dp, end = 16.dp)
            ) {
                val scope = rememberCoroutineScope()
                FloatingActionButton(
                    onClick = {
                        scope.launch {
                            listState.animateScrollToItem(index = 0)
                        }
                    },
                    containerColor = MaterialTheme.colorScheme.secondaryContainer,
                    contentColor = MaterialTheme.colorScheme.onSecondaryContainer,
                    modifier = Modifier.size(48.dp)
                ) {
                    Icon(Icons.Default.ArrowUpward, contentDescription = "Scroll to top")
                }
            }
        }
    }
}
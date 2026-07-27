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
 * along with OpenJournal.  If not, see https://www.gnu.org/licenses/gpl-3.0.en.html.
 */

package org.openpsychonaut.openjournal.ui.tabs.stats

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.IntrinsicSize
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.outlined.Person
import androidx.compose.material.icons.outlined.Timeline
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ElevatedCard
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.PrimaryTabRow
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Tab
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import org.openpsychonaut.openjournal.ui.YOU
import org.openpsychonaut.openjournal.ui.tabs.search.substance.roa.toReadableString
import org.openpsychonaut.openjournal.ui.theme.OpenJournalTheme
import org.openpsychonaut.openjournal.ui.theme.horizontalPadding

@Composable
fun StatsScreen(
    viewModel: StatsViewModel = hiltViewModel(),
    navigateToSubstanceCompanion: (substanceName: String, consumerName: String?) -> Unit,
) {
    val statsModel by viewModel.statsModelFlow.collectAsState()
    val consumerNamesSorted by viewModel.sortedConsumerNamesFlow.collectAsState()
    
    StatsScreenContent(
        navigateToSubstanceCompanion = navigateToSubstanceCompanion,
        onTapOption = viewModel::onTapOption,
        statsModel = statsModel,
        onChangeConsumerName = viewModel::onChangeConsumer,
        consumerNamesSorted = consumerNamesSorted,
    )
}

@Preview
@Composable
fun StatsPreview(
    @PreviewParameter(StatsPreviewProvider::class) statsModel: StatsModel
) {
    OpenJournalTheme {
        StatsScreenContent(
            navigateToSubstanceCompanion = { _, _ -> },
            onTapOption = {},
            statsModel = statsModel,
            onChangeConsumerName = {},
            consumerNamesSorted = listOf("Someone else"),
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun StatsScreenContent(
    navigateToSubstanceCompanion: (substanceName: String, consumerName: String?) -> Unit,
    onTapOption: (option: TimePickerOption) -> Unit,
    statsModel: StatsModel,
    onChangeConsumerName: (String?) -> Unit,
    consumerNamesSorted: List<String>,
) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { 
                    Column {
                        Text(
                            text = "Usage Stats",
                            style = MaterialTheme.typography.titleLarge,
                            fontWeight = FontWeight.Bold
                        )
                        if (statsModel.consumerName != null) {
                            Text(
                                text = "For: ${statsModel.consumerName}",
                                style = MaterialTheme.typography.labelSmall,
                                color = MaterialTheme.colorScheme.secondary
                            )
                        }
                    }
                },
                actions = {
                    if (consumerNamesSorted.isNotEmpty()) {
                        var isConsumerSelectionExpanded by remember { mutableStateOf(false) }
                        IconButton(onClick = { isConsumerSelectionExpanded = true }) {
                            Icon(Icons.Outlined.Person, contentDescription = "Switch User")
                        }
                        DropdownMenu(
                            expanded = isConsumerSelectionExpanded,
                            onDismissRequest = { isConsumerSelectionExpanded = false }
                        ) {
                            DropdownMenuItem(
                                text = { Text(YOU) },
                                onClick = {
                                    onChangeConsumerName(null)
                                    isConsumerSelectionExpanded = false
                                },
                                leadingIcon = {
                                    if (statsModel.consumerName == null) {
                                        Icon(Icons.Filled.Check, null, modifier = Modifier.size(ButtonDefaults.IconSize))
                                    }
                                }
                            )
                            consumerNamesSorted.forEach { consumerName ->
                                DropdownMenuItem(
                                    text = { Text(consumerName) },
                                    onClick = {
                                        onChangeConsumerName(consumerName)
                                        isConsumerSelectionExpanded = false
                                    },
                                    leadingIcon = {
                                        if (statsModel.consumerName == consumerName) {
                                            Icon(Icons.Filled.Check, null, modifier = Modifier.size(ButtonDefaults.IconSize))
                                        }
                                    }
                                )
                            }
                        }
                    }
                }
            )
        },
    ) { padding ->
        if (!statsModel.areThereAnyIngestions) {
            EmptyScreenDisclaimer(
                title = "No data to analyze",
                description = "Log your first ingestion to see detailed usage statistics and charts."
            )
        } else {
            Column(modifier = Modifier.padding(padding)) {
                PrimaryTabRow(
                    selectedTabIndex = statsModel.selectedOption.tabIndex,
                    containerColor = MaterialTheme.colorScheme.surface,
                    divider = {}
                ) {
                    TimePickerOption.entries.forEachIndexed { index, option ->
                        Tab(
                            text = { 
                                Text(
                                    option.displayText,
                                    style = MaterialTheme.typography.labelLarge,
                                    fontWeight = if (statsModel.selectedOption.tabIndex == index) FontWeight.Bold else FontWeight.Normal
                                ) 
                            },
                            selected = statsModel.selectedOption.tabIndex == index,
                            onClick = { onTapOption(option) }
                        )
                    }
                }
                
                if (statsModel.statItems.isNotEmpty()) {
                    val isDarkTheme = isSystemInDarkTheme()
                    LazyColumn(
                        modifier = Modifier.fillMaxSize(),
                        contentPadding = PaddingValues(bottom = 32.dp)
                    ) {
                        item {
                            ElevatedCard(
                                modifier = Modifier
                                    .padding(16.dp)
                                    .fillMaxWidth(),
                                shape = RoundedCornerShape(24.dp),
                                colors = CardDefaults.elevatedCardColors(
                                    containerColor = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.3f)
                                )
                            ) {
                                Column(modifier = Modifier.padding(16.dp)) {
                                    Row(verticalAlignment = Alignment.CenterVertically) {
                                        Icon(Icons.Outlined.Timeline, null, tint = MaterialTheme.colorScheme.primary, modifier = Modifier.size(20.dp))
                                        Spacer(Modifier.width(12.dp))
                                        Text(
                                            text = "Activity since ${statsModel.startDateText}",
                                            style = MaterialTheme.typography.titleSmall,
                                            fontWeight = FontWeight.Bold
                                        )
                                    }
                                    Spacer(Modifier.height(16.dp))
                                    BarChart(
                                        buckets = statsModel.chartBuckets,
                                        startDateText = statsModel.startDateText
                                    )
                                }
                            }
                        }

                        item {
                            Text(
                                text = "Substance Breakdown",
                                style = MaterialTheme.typography.labelLarge,
                                color = MaterialTheme.colorScheme.primary,
                                modifier = Modifier.padding(horizontal = 20.dp, vertical = 8.dp)
                            )
                        }

                        items(statsModel.statItems) { subStat ->
                            ElevatedCard(
                                modifier = Modifier
                                    .padding(horizontal = 16.dp, vertical = 6.dp)
                                    .fillMaxWidth(),
                                shape = RoundedCornerShape(16.dp),
                                onClick = { navigateToSubstanceCompanion(subStat.substanceName, statsModel.consumerName) }
                            ) {
                                Row(
                                    modifier = Modifier
                                        .padding(16.dp)
                                        .height(IntrinsicSize.Min),
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    Box(
                                        modifier = Modifier
                                            .width(6.dp)
                                            .fillMaxHeight()
                                            .clip(RoundedCornerShape(3.dp))
                                            .background(subStat.color.getComposeColor(isDarkTheme))
                                    )
                                    Spacer(Modifier.width(16.dp))
                                    Column(modifier = Modifier.weight(1f)) {
                                        Text(
                                            text = subStat.substanceName,
                                            style = MaterialTheme.typography.titleMedium,
                                            fontWeight = FontWeight.Bold
                                        )
                                        Text(
                                            text = "${subStat.experienceCount} ${if (subStat.experienceCount == 1) "session" else "sessions"}",
                                            style = MaterialTheme.typography.bodySmall,
                                            color = MaterialTheme.colorScheme.onSurfaceVariant
                                        )
                                    }
                                    Column(horizontalAlignment = Alignment.End) {
                                        subStat.totalDose?.let { dose ->
                                            Text(
                                                text = "${if (dose.isEstimate) "~" else ""}${dose.dose.toReadableString()} ${dose.units}",
                                                style = MaterialTheme.typography.bodyMedium,
                                                fontWeight = FontWeight.Medium
                                            )
                                        }
                                        Text(
                                            text = subStat.routeCounts.joinToString(", ") { "${it.count}x ${it.administrationRoute.displayText.lowercase()}" },
                                            style = MaterialTheme.typography.labelSmall,
                                            color = MaterialTheme.colorScheme.secondary
                                        )
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                        EmptyScreenDisclaimer(
                            title = "Quiet period",
                            description = "No logs found for this time range. Try selecting a broader view."
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun EmptyScreenDisclaimer(title: String, description: String) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Box(
            modifier = Modifier
                .size(80.dp)
                .background(MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f), CircleShape),
            contentAlignment = Alignment.Center
        ) {
            Icon(
                Icons.Outlined.Timeline,
                contentDescription = null,
                modifier = Modifier.size(40.dp),
                tint = MaterialTheme.colorScheme.outlineVariant
            )
        }
        Spacer(modifier = Modifier.height(24.dp))
        Text(
            text = title,
            style = MaterialTheme.typography.headlineSmall,
            fontWeight = FontWeight.Bold,
            textAlign = TextAlign.Center
        )
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            text = description,
            style = MaterialTheme.typography.bodyMedium,
            textAlign = TextAlign.Center,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            lineHeight = 22.sp
        )
    }
}

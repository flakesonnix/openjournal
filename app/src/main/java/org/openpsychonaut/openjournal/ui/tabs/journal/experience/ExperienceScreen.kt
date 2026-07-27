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

package org.openpsychonaut.openjournal.ui.tabs.journal.experience

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.outlined.NoteAdd
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.ArrowDropDown
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material.icons.filled.OpenInFull
import androidx.compose.material.icons.filled.Star
import androidx.compose.material.icons.outlined.Add
import androidx.compose.material.icons.outlined.AutoAwesome
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.Edit
import androidx.compose.material.icons.outlined.ExposurePlus2
import androidx.compose.material.icons.outlined.Info
import androidx.compose.material.icons.outlined.Notes
import androidx.compose.material.icons.outlined.StarOutline
import androidx.compose.material.icons.outlined.Timer
import androidx.compose.material.icons.outlined.Warning
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ElevatedCard
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExtendedFloatingActionButton
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SuggestionChip
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.MutableState
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import org.openpsychonaut.openjournal.data.room.experiences.entities.TimedNote
import org.openpsychonaut.openjournal.data.substances.AdministrationRoute
import org.openpsychonaut.openjournal.ui.FULL_STOMACH_DISCLAIMER
import org.openpsychonaut.openjournal.ui.YOU
import org.openpsychonaut.openjournal.ui.tabs.journal.addingestion.interactions.Interaction
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.CardTitle
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.CumulativeDoseRow
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.IngestionTimeOrDurationText
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.InteractionRow
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.NoteOrRatingTimeOrDurationText
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.SavedTimeDisplayOption
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.TimeDisplayOption
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.getDurationText
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.ingestion.IngestionRow
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.rating.OverallRatingRow
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.rating.TimedRatingRow
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.timednote.TimedNoteRow
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.models.ConsumerWithIngestions
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.models.CumulativeDose
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.models.OneExperienceScreenModel
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.timeline.AllTimelines
import org.openpsychonaut.openjournal.ui.theme.OpenJournalTheme
import org.openpsychonaut.openjournal.ui.theme.horizontalPadding
import org.openpsychonaut.openjournal.ui.utils.getDateWithWeekdayText
import kotlinx.coroutines.delay
import java.time.Instant
import java.time.temporal.ChronoUnit

@Composable
fun ExperienceScreen(
    viewModel: ExperienceViewModel = hiltViewModel(),
    navigateToAddIngestionSearch: () -> Unit,
    navigateToEditExperienceScreen: () -> Unit,
    navigateToExplainTimeline: () -> Unit,
    navigateToIngestionScreen: (ingestionId: Int) -> Unit,
    navigateToAddRatingScreen: () -> Unit,
    navigateToAddTimedNoteScreen: () -> Unit,
    navigateToEditRatingScreen: (ratingId: Int) -> Unit,
    navigateToEditTimedNoteScreen: (timedNoteId: Int) -> Unit,
    navigateToTimelineScreen: (consumerName: String) -> Unit,
    navigateBack: () -> Unit,
) {
    val ingestionsWithCompanions = viewModel.ingestionsWithCompanionsFlow.collectAsState().value
    val experience = viewModel.experienceFlow.collectAsState().value
    val isFavorite = viewModel.isFavoriteFlow.collectAsState().value
    val oneExperienceScreenModel = OneExperienceScreenModel(
        isFavorite = isFavorite,
        title = experience?.title ?: "",
        firstIngestionTime = ingestionsWithCompanions.minOfOrNull { it.ingestion.time }
            ?: experience?.sortDate ?: Instant.now(),
        notes = experience?.text ?: "",
        locationName = experience?.location?.name ?: "",
        isCurrentExperience = viewModel.isCurrentExperienceFlow.collectAsState().value,
        ingestionElements = viewModel.ingestionElementsFlow.collectAsState().value,
        cumulativeDoses = viewModel.cumulativeDosesFlow.collectAsState().value,
        interactions = viewModel.interactionsFlow.collectAsState().value,
        interactionExplanations = viewModel.interactionExplanationsFlow.collectAsState().value,
        ratings = viewModel.ratingsFlow.collectAsState().value,
        timedNotesSorted = viewModel.timedNotesSortedFlow.collectAsState().value,
        consumersWithIngestions = viewModel.consumersWithIngestionsFlow.collectAsState().value,
        dataForEffectLines = viewModel.dataForEffectTimelinesFlow.collectAsState().value
    )
    ExperienceScreen(
        oneExperienceScreenModel = oneExperienceScreenModel,
        timelineDisplayOption = viewModel.timelineDisplayOptionFlow.collectAsState().value,
        isOralDisclaimerHidden = viewModel.isOralTimelineDisclaimerHidden.collectAsState().value,
        onChangeIsOralDisclaimerHidden = viewModel::saveOralDisclaimerIsHidden,
        addIngestion = {
            viewModel.saveLastIngestionTimeOfExperience()
            navigateToAddIngestionSearch()
        },
        deleteExperience = viewModel::deleteExperience,
        navigateToEditExperienceScreen = navigateToEditExperienceScreen,
        navigateToExplainTimeline = navigateToExplainTimeline,
        navigateToIngestionScreen = navigateToIngestionScreen,
        navigateToAddRatingScreen = navigateToAddRatingScreen,
        navigateToAddTimedNoteScreen = navigateToAddTimedNoteScreen,
        navigateBack = navigateBack,
        saveIsFavorite = viewModel::saveIsFavorite,
        navigateToEditRatingScreen = navigateToEditRatingScreen,
        navigateToEditTimedNoteScreen = navigateToEditTimedNoteScreen,
        savedTimeDisplayOption = viewModel.savedTimeDisplayOption.collectAsState().value,
        timeDisplayOption = viewModel.timeDisplayOptionFlow.collectAsState().value,
        onChangeTimeDisplayOption = viewModel::saveTimeDisplayOption,
        navigateToTimelineScreen = navigateToTimelineScreen,
        areDosageDotsHidden = viewModel.areDosageDotsHiddenFlow.collectAsState().value,
        isTimelineHidden = viewModel.isTimelineHiddenFlow.collectAsState().value
    )
}

@Preview
@Composable
fun ExperienceScreenPreview(
    @PreviewParameter(
        OneExperienceScreenPreviewProvider::class,
        limit = 1
    ) oneExperienceScreenModel: OneExperienceScreenModel
) {
    OpenJournalTheme {
        ExperienceScreen(
            oneExperienceScreenModel = oneExperienceScreenModel,
            timelineDisplayOption = TimelineDisplayOption.Loading,
            isOralDisclaimerHidden = false,
            onChangeIsOralDisclaimerHidden = {},
            addIngestion = {},
            deleteExperience = {},
            navigateToEditExperienceScreen = {},
            navigateToExplainTimeline = {},
            navigateToIngestionScreen = {},
            navigateToAddRatingScreen = {},
            navigateToAddTimedNoteScreen = {},
            navigateBack = {},
            saveIsFavorite = {},
            navigateToEditRatingScreen = {},
            navigateToEditTimedNoteScreen = {},
            savedTimeDisplayOption = SavedTimeDisplayOption.RELATIVE_TO_START,
            timeDisplayOption = TimeDisplayOption.RELATIVE_TO_START,
            onChangeTimeDisplayOption = {},
            navigateToTimelineScreen = {},
            areDosageDotsHidden = false,
            isTimelineHidden = false
        )
    }
}

@Composable
fun ExperienceScreen(
    oneExperienceScreenModel: OneExperienceScreenModel,
    timelineDisplayOption: TimelineDisplayOption,
    isOralDisclaimerHidden: Boolean,
    onChangeIsOralDisclaimerHidden: (Boolean) -> Unit,
    addIngestion: () -> Unit,
    deleteExperience: () -> Unit,
    navigateToEditExperienceScreen: () -> Unit,
    navigateToExplainTimeline: () -> Unit,
    navigateToIngestionScreen: (ingestionId: Int) -> Unit,
    navigateToAddRatingScreen: () -> Unit,
    navigateToAddTimedNoteScreen: () -> Unit,
    navigateBack: () -> Unit,
    saveIsFavorite: (Boolean) -> Unit,
    navigateToEditRatingScreen: (ratingId: Int) -> Unit,
    navigateToEditTimedNoteScreen: (timedNoteId: Int) -> Unit,
    savedTimeDisplayOption: SavedTimeDisplayOption,
    timeDisplayOption: TimeDisplayOption,
    onChangeTimeDisplayOption: (SavedTimeDisplayOption) -> Unit,
    navigateToTimelineScreen: (consumerName: String) -> Unit,
    areDosageDotsHidden: Boolean,
    isTimelineHidden: Boolean,
) {
    Scaffold(
        topBar = {
            ExperienceTopBar(
                oneExperienceScreenModel = oneExperienceScreenModel,
                onChangeTimeDisplayOption = onChangeTimeDisplayOption,
                savedTimeDisplayOption = savedTimeDisplayOption,
                deleteExperience = deleteExperience,
                navigateBack = navigateBack,
                navigateToEditExperienceScreen = navigateToEditExperienceScreen,
                saveIsFavorite = saveIsFavorite,
                navigateToAddTimedNoteScreen = navigateToAddTimedNoteScreen,
                navigateToAddRatingScreen = navigateToAddRatingScreen,
                addIngestion = addIngestion
            )
        },
        floatingActionButton = {
            AddIngestionFAB(oneExperienceScreenModel, addIngestion)
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .verticalScroll(rememberScrollState())
                .padding(padding)
                .padding(bottom = 80.dp)
        ) {
            val verticalCardPadding = 8.dp
            
            // Timeline Section
            MyTimelineSection(
                timelineDisplayOption = timelineDisplayOption,
                verticalCardPadding = verticalCardPadding,
                navigateToExplainTimeline = navigateToExplainTimeline,
                navigateToTimelineScreen = navigateToTimelineScreen,
                oneExperienceScreenModel = oneExperienceScreenModel,
                timeDisplayOption = timeDisplayOption,
                isOralDisclaimerHidden = isOralDisclaimerHidden,
                onChangeIsOralDisclaimerHidden = onChangeIsOralDisclaimerHidden,
            )

            // Ingestions List
            if (oneExperienceScreenModel.ingestionElements.isNotEmpty()) {
                ExperienceSection(
                    title = "Ingestions",
                    icon = Icons.Filled.Add,
                    verticalCardPadding = verticalCardPadding
                ) {
                    oneExperienceScreenModel.ingestionElements.forEachIndexed { index, ingestionElement ->
                        IngestionRow(
                            ingestionElement = ingestionElement,
                            areDosageDotsHidden = areDosageDotsHidden,
                            modifier = Modifier
                                .clickable {
                                    navigateToIngestionScreen(ingestionElement.ingestionWithCompanionAndCustomUnit.ingestion.id)
                                }
                                .fillMaxWidth()
                                .padding(vertical = 12.dp, horizontal = horizontalPadding)
                        ) {
                            val ingestion = ingestionElement.ingestionWithCompanionAndCustomUnit.ingestion
                            IngestionTimeOrDurationText(
                                time = ingestion.time,
                                endTime = ingestion.endTime,
                                index = index,
                                timeDisplayOption = timeDisplayOption,
                                allTimesSortedMap = oneExperienceScreenModel.ingestionElements.map { it.ingestionWithCompanionAndCustomUnit.ingestion.time }
                            )
                        }
                        if (index < oneExperienceScreenModel.ingestionElements.size - 1) {
                            HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.3f))
                        }
                    }
                    
                    if (oneExperienceScreenModel.isCurrentExperience) {
                        val lastTime = oneExperienceScreenModel.ingestionElements.last().ingestionWithCompanionAndCustomUnit.ingestion.time
                        HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.3f))
                        Box(modifier = Modifier.padding(12.dp)) {
                             if (timeDisplayOption == TimeDisplayOption.TIME_BETWEEN) {
                                LastIngestionRelativeToNowText(lastIngestionTime = lastTime)
                            } else if (timeDisplayOption == TimeDisplayOption.RELATIVE_TO_START) {
                                NowRelativeToStartTimeText(startTime = oneExperienceScreenModel.firstIngestionTime)
                            }
                        }
                    }
                }
            }

            // Cumulative Doses
            val cumulativeDoses = oneExperienceScreenModel.cumulativeDoses
            if (cumulativeDoses.isNotEmpty()) {
                ExperienceSection(
                    title = "Cumulative Totals",
                    icon = Icons.Outlined.AutoAwesome,
                    verticalCardPadding = verticalCardPadding
                ) {
                    cumulativeDoses.forEachIndexed { index, cumulativeDose ->
                        CumulativeDoseRow(
                            cumulativeDose = cumulativeDose,
                            areDosageDotsHidden = areDosageDotsHidden,
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 12.dp, horizontal = horizontalPadding)
                        )
                        if (index < cumulativeDoses.size - 1) {
                            HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.3f))
                        }
                    }
                }
            }

            // Timed Notes
            val timedNotesSorted = oneExperienceScreenModel.timedNotesSorted
            if (timedNotesSorted.isNotEmpty()) {
                ExperienceSection(
                    title = "Timeline Events",
                    icon = Icons.AutoMirrored.Outlined.NoteAdd,
                    verticalCardPadding = verticalCardPadding
                ) {
                    timedNotesSorted.forEachIndexed { index, timedNote ->
                        TimedNoteRow(
                            timedNote = timedNote,
                            modifier = Modifier
                                .clickable {
                                    navigateToEditTimedNoteScreen(timedNote.id)
                                }
                                .fillMaxWidth()
                                .padding(vertical = 12.dp, horizontal = horizontalPadding)
                        ) {
                            NoteOrRatingTimeOrDurationText(
                                time = timedNote.time,
                                timeDisplayOption = timeDisplayOption,
                                firstIngestionTime = oneExperienceScreenModel.firstIngestionTime
                            )
                        }
                        if (index < timedNotesSorted.size - 1) {
                            HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.3f))
                        }
                    }
                }
            }

            // Ratings
            if (oneExperienceScreenModel.ratings.isNotEmpty()) {
                ExperienceSection(
                    title = "Intensity Ratings",
                    icon = Icons.Outlined.ExposurePlus2,
                    verticalCardPadding = verticalCardPadding
                ) {
                    val ratingsWithTime = oneExperienceScreenModel.ratings.mapNotNull { rating ->
                        rating.time?.let { Pair(it, rating) }
                    }.sortedBy { it.first }
                    
                    ratingsWithTime.forEachIndexed { index, pair ->
                        TimedRatingRow(
                            modifier = Modifier
                                .clickable { navigateToEditRatingScreen(pair.second.id) }
                                .fillMaxWidth()
                                .padding(vertical = 12.dp, horizontal = horizontalPadding),
                            ratingSign = pair.second.option.sign
                        ) {
                            NoteOrRatingTimeOrDurationText(
                                time = pair.first,
                                timeDisplayOption = timeDisplayOption,
                                firstIngestionTime = oneExperienceScreenModel.firstIngestionTime
                            )
                        }
                        if (index < ratingsWithTime.size - 1) {
                            HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.3f))
                        }
                    }
                    
                    oneExperienceScreenModel.ratings.firstOrNull { it.time == null }?.let { overallRating ->
                        if (ratingsWithTime.isNotEmpty()) HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.3f))
                        OverallRatingRow(
                            modifier = Modifier
                                .clickable { navigateToEditRatingScreen(overallRating.id) }
                                .fillMaxWidth()
                                .padding(vertical = 12.dp, horizontal = horizontalPadding),
                            ratingSign = overallRating.option.sign
                        )
                    }
                }
            }

            // Notes Section
            if (oneExperienceScreenModel.notes.isNotBlank() || oneExperienceScreenModel.locationName.isNotBlank()) {
                ExperienceSection(
                    title = "Journal Entry",
                    icon = Icons.Outlined.Notes,
                    verticalCardPadding = verticalCardPadding
                ) {
                    Column(modifier = Modifier
                        .clickable { navigateToEditExperienceScreen() }
                        .padding(16.dp)
                        .fillMaxWidth()) {
                        if (oneExperienceScreenModel.notes.isNotBlank()) {
                            Text(
                                text = oneExperienceScreenModel.notes,
                                style = MaterialTheme.typography.bodyLarge,
                                lineHeight = 24.sp
                            )
                        }
                        if (oneExperienceScreenModel.locationName.isNotBlank()) {
                            Spacer(modifier = Modifier.height(12.dp))
                            Text(
                                text = "📍 ${oneExperienceScreenModel.locationName}",
                                style = MaterialTheme.typography.labelLarge,
                                color = MaterialTheme.colorScheme.primary
                            )
                        }
                    }
                }
            }

            // Consumers
            oneExperienceScreenModel.consumersWithIngestions.forEach { consumerWithIngestions ->
                ExperienceSection(
                    title = consumerWithIngestions.consumerName,
                    icon = Icons.Default.Add,
                    verticalCardPadding = verticalCardPadding,
                    headerAction = {
                        if (!isTimelineHidden) {
                            IconButton(onClick = { navigateToTimelineScreen(consumerWithIngestions.consumerName) }) {
                                Icon(Icons.Default.OpenInFull, contentDescription = "Expand")
                            }
                        }
                    }
                ) {
                    consumerWithIngestions.ingestionElements.forEachIndexed { index, ingestionElement ->
                         IngestionRow(
                            ingestionElement = ingestionElement,
                            areDosageDotsHidden = areDosageDotsHidden,
                            modifier = Modifier
                                .clickable {
                                    navigateToIngestionScreen(ingestionElement.ingestionWithCompanionAndCustomUnit.ingestion.id)
                                }
                                .fillMaxWidth()
                                .padding(vertical = 12.dp, horizontal = horizontalPadding)
                        ) {
                            val ingestion = ingestionElement.ingestionWithCompanionAndCustomUnit.ingestion
                            IngestionTimeOrDurationText(
                                time = ingestion.time,
                                endTime = ingestion.endTime,
                                index = index,
                                timeDisplayOption = timeDisplayOption,
                                allTimesSortedMap = consumerWithIngestions.ingestionElements.map { it.ingestionWithCompanionAndCustomUnit.ingestion.time }
                            )
                        }
                        if (index < consumerWithIngestions.ingestionElements.size - 1) {
                            HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.3f))
                        }
                    }
                }
            }

            // Interactions
            if (oneExperienceScreenModel.interactions.isNotEmpty()) {
                ExperienceSection(
                    title = "Safety Interactions",
                    icon = Icons.Outlined.Warning,
                    verticalCardPadding = verticalCardPadding
                ) {
                    Column(modifier = Modifier.padding(bottom = 12.dp)) {
                        oneExperienceScreenModel.interactions.forEachIndexed { index, interaction ->
                            InteractionRow(interaction = interaction)
                            if (index < oneExperienceScreenModel.interactions.size - 1) {
                                HorizontalDivider(modifier = Modifier.padding(horizontal = horizontalPadding).alpha(0.3f))
                            }
                        }
                        Spacer(modifier = Modifier.height(12.dp))
                        FlowRow(
                            horizontalArrangement = Arrangement.spacedBy(8.dp),
                            modifier = Modifier.padding(horizontal = 16.dp)
                        ) {
                            oneExperienceScreenModel.interactionExplanations.forEach {
                                val uriHandler = LocalUriHandler.current
                                SuggestionChip(
                                    onClick = { uriHandler.openUri(it.url) },
                                    label = { Text(it.name) }
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun ExperienceSection(
    title: String,
    icon: ImageVector,
    verticalCardPadding: Dp,
    headerAction: @Composable (() -> Unit)? = null,
    content: @Composable () -> Unit
) {
    ElevatedCard(
        modifier = Modifier
            .padding(vertical = verticalCardPadding)
            .fillMaxWidth(),
        shape = RoundedCornerShape(24.dp)
    ) {
        Column {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(start = 16.dp, end = 8.dp, top = 8.dp, bottom = 8.dp),
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Icon(icon, contentDescription = null, tint = MaterialTheme.colorScheme.primary, modifier = Modifier.size(20.dp))
                    Spacer(Modifier.width(12.dp))
                    Text(
                        text = title,
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.Bold,
                        color = MaterialTheme.colorScheme.primary
                    )
                }
                headerAction?.invoke()
            }
            HorizontalDivider(modifier = Modifier.alpha(0.2f), thickness = 0.5.dp)
            content()
        }
    }
}

@Composable
private fun MyTimelineSection(
    timelineDisplayOption: TimelineDisplayOption,
    verticalCardPadding: Dp,
    navigateToExplainTimeline: () -> Unit,
    navigateToTimelineScreen: (consumerName: String) -> Unit,
    oneExperienceScreenModel: OneExperienceScreenModel,
    timeDisplayOption: TimeDisplayOption,
    isOralDisclaimerHidden: Boolean,
    onChangeIsOralDisclaimerHidden: (Boolean) -> Unit,
) {
    when (timelineDisplayOption) {
        is TimelineDisplayOption.Shown -> {
            ExperienceSection(
                title = "Effect Timeline",
                icon = Icons.Outlined.Timer,
                verticalCardPadding = verticalCardPadding,
                headerAction = {
                    Row {
                        IconButton(onClick = navigateToExplainTimeline) {
                            Icon(Icons.Outlined.Info, contentDescription = "Info")
                        }
                        IconButton(onClick = { navigateToTimelineScreen(YOU) }) {
                            Icon(Icons.Default.OpenInFull, contentDescription = "Expand")
                        }
                    }
                }
            ) {
                Column(
                    modifier = Modifier
                        .padding(16.dp)
                        .fillMaxWidth()
                ) {
                    AllTimelines(
                        model = timelineDisplayOption.allTimelinesModel,
                        timeDisplayOption = timeDisplayOption,
                        isShowingCurrentTime = true,
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(200.dp)
                            .clip(RoundedCornerShape(12.dp))
                            .background(MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.2f))
                    )
                    
                    val hasOralIngestion = oneExperienceScreenModel.ingestionElements.any { it.ingestionWithCompanionAndCustomUnit.ingestion.administrationRoute == AdministrationRoute.ORAL }
                    if (hasOralIngestion && !isOralDisclaimerHidden) {
                        Spacer(modifier = Modifier.height(12.dp))
                        Row(
                            verticalAlignment = Alignment.CenterVertically,
                            modifier = Modifier
                                .fillMaxWidth()
                                .background(MaterialTheme.colorScheme.secondaryContainer.copy(alpha = 0.4f), RoundedCornerShape(8.dp))
                                .padding(8.dp)
                        ) {
                            Text(
                                text = FULL_STOMACH_DISCLAIMER,
                                style = MaterialTheme.typography.bodySmall,
                                modifier = Modifier.weight(1f)
                            )
                            IconButton(onClick = { onChangeIsOralDisclaimerHidden(true) }, modifier = Modifier.size(24.dp)) {
                                Icon(Icons.Default.Close, contentDescription = "Close", modifier = Modifier.size(16.dp))
                            }
                        }
                    }
                }
            }
        }
        TimelineDisplayOption.Loading -> LinearProgressIndicator(modifier = Modifier.fillMaxWidth())
        else -> {}
    }
}


@Composable
private fun AddIngestionFAB(
    oneExperienceScreenModel: OneExperienceScreenModel,
    addIngestion: () -> Unit
) {
    val wasAnyIngestionCreatedInLast4Hours =
        oneExperienceScreenModel.ingestionElements.mapNotNull { it.ingestionWithCompanionAndCustomUnit.ingestion.creationDate }
            .any {
                it > Instant.now().minus(4, ChronoUnit.HOURS)
            }
    if (oneExperienceScreenModel.isCurrentExperience || wasAnyIngestionCreatedInLast4Hours) {
        ExtendedFloatingActionButton(
            onClick = addIngestion,
            containerColor = MaterialTheme.colorScheme.primaryContainer,
            contentColor = MaterialTheme.colorScheme.onPrimaryContainer,
            icon = {
                Icon(
                    Icons.Filled.Add,
                    contentDescription = "Add"
                )
            },
            text = { Text("Log More") }
        )
    }
}

@Composable
@OptIn(ExperimentalMaterial3Api::class)
private fun ExperienceTopBar(
    oneExperienceScreenModel: OneExperienceScreenModel,
    onChangeTimeDisplayOption: (SavedTimeDisplayOption) -> Unit,
    savedTimeDisplayOption: SavedTimeDisplayOption,
    deleteExperience: () -> Unit,
    navigateBack: () -> Unit,
    navigateToEditExperienceScreen: () -> Unit,
    saveIsFavorite: (Boolean) -> Unit,
    navigateToAddTimedNoteScreen: () -> Unit,
    navigateToAddRatingScreen: () -> Unit,
    addIngestion: () -> Unit
) {
    TopAppBar(
        title = { 
            Column {
                Text(
                    text = oneExperienceScreenModel.title,
                    maxLines = 1,
                    style = MaterialTheme.typography.titleLarge,
                    fontWeight = FontWeight.Bold
                )
                Text(
                    text = oneExperienceScreenModel.firstIngestionTime.getDateWithWeekdayText(),
                    style = MaterialTheme.typography.labelSmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
        },
        actions = {
            var areTimeOptionsExpanded by remember { mutableStateOf(false) }
            IconButton(onClick = { areTimeOptionsExpanded = true }) {
                Icon(Icons.Outlined.Timer, contentDescription = "Time options")
            }
            DropdownMenu(
                expanded = areTimeOptionsExpanded,
                onDismissRequest = { areTimeOptionsExpanded = false }
            ) {
                SavedTimeDisplayOption.entries.forEach { option ->
                    DropdownMenuItem(
                        text = { Text(option.text) },
                        onClick = {
                            onChangeTimeDisplayOption(option)
                            areTimeOptionsExpanded = false
                        },
                        leadingIcon = {
                            if (option == savedTimeDisplayOption) {
                                Icon(
                                    Icons.Filled.Check,
                                    contentDescription = "Selected",
                                    modifier = Modifier.size(ButtonDefaults.IconSize)
                                )
                            }
                        }
                    )
                }
            }

            var areAddOptionsExpanded by remember { mutableStateOf(false) }
            IconButton(onClick = { areAddOptionsExpanded = true }) {
                Icon(Icons.Outlined.Add, contentDescription = "Add items")
            }
            DropdownMenu(
                expanded = areAddOptionsExpanded,
                onDismissRequest = { areAddOptionsExpanded = false }
            ) {
                DropdownMenuItem(
                    text = { Text("Add Ingestion") },
                    onClick = {
                        addIngestion()
                        areAddOptionsExpanded = false
                    },
                    leadingIcon = { Icon(Icons.Outlined.Add, contentDescription = null) }
                )
                DropdownMenuItem(
                    text = { Text("Add Note") },
                    onClick = {
                        navigateToAddTimedNoteScreen()
                        areAddOptionsExpanded = false
                    },
                    leadingIcon = { Icon(Icons.AutoMirrored.Outlined.NoteAdd, contentDescription = null) }
                )
                DropdownMenuItem(
                    text = { Text("Add Rating") },
                    onClick = {
                        navigateToAddRatingScreen()
                        areAddOptionsExpanded = false
                    },
                    leadingIcon = { Icon(Icons.Outlined.ExposurePlus2, contentDescription = null) }
                )
            }

            var areEditOptionsExpanded by remember { mutableStateOf(false) }
            IconButton(onClick = { areEditOptionsExpanded = true }) {
                Icon(Icons.Default.Edit, contentDescription = "Options")
            }
            var isShowingDeleteDialog by remember { mutableStateOf(false) }
            AnimatedVisibility(visible = isShowingDeleteDialog) {
                AlertDialog(
                    onDismissRequest = { isShowingDeleteDialog = false },
                    title = { Text("Delete session?") },
                    text = { Text("This will permanently remove all logs from this session.") },
                    confirmButton = {
                        TextButton(
                            onClick = {
                                isShowingDeleteDialog = false
                                deleteExperience()
                                navigateBack()
                            }
                        ) { Text("Delete", color = MaterialTheme.colorScheme.error) }
                    },
                    dismissButton = {
                        TextButton(onClick = { isShowingDeleteDialog = false }) { Text("Cancel") }
                    }
                )
            }
            DropdownMenu(
                expanded = areEditOptionsExpanded,
                onDismissRequest = { areEditOptionsExpanded = false }
            ) {
                DropdownMenuItem(
                    text = { Text("Edit Details") },
                    onClick = {
                        navigateToEditExperienceScreen()
                        areEditOptionsExpanded = false
                    },
                    leadingIcon = { Icon(Icons.Outlined.Edit, contentDescription = null) }
                )
                val isFavorite = oneExperienceScreenModel.isFavorite
                DropdownMenuItem(
                    text = { Text(if (isFavorite) "Unmark Favorite" else "Mark Favorite") },
                    onClick = {
                        saveIsFavorite(!isFavorite)
                        areEditOptionsExpanded = false
                    },
                    leadingIcon = { 
                        Icon(
                            if (isFavorite) Icons.Filled.Star else Icons.Outlined.StarOutline,
                            contentDescription = null
                        ) 
                    }
                )
                DropdownMenuItem(
                    text = { Text("Delete Session") },
                    onClick = {
                        isShowingDeleteDialog = true
                        areEditOptionsExpanded = false
                    },
                    leadingIcon = { Icon(Icons.Outlined.Delete, contentDescription = null) }
                )
            }
        }
    )
}

@Composable
private fun LastIngestionRelativeToNowText(lastIngestionTime: Instant) {
    val now: MutableState<Instant> = remember { mutableStateOf(Instant.now()) }
    LaunchedEffect(key1 = "updateTime") {
        while (true) {
            delay(10000L)
            now.value = Instant.now()
        }
    }
    val relativeTime = "Last ingestion " + getDurationText(fromInstant = lastIngestionTime, toInstant = now.value) + " ago"
    Text(
        text = relativeTime,
        style = MaterialTheme.typography.bodySmall,
        color = MaterialTheme.colorScheme.secondary
    )
}

@Composable
private fun NowRelativeToStartTimeText(startTime: Instant) {
    val now: MutableState<Instant> = remember { mutableStateOf(Instant.now()) }
    LaunchedEffect(key1 = "updateTime") {
        while (true) {
            delay(10000L)
            now.value = Instant.now()
        }
    }
    val relativeTime = "Current duration: " + getDurationText(fromInstant = startTime, toInstant = now.value)
    Text(
        text = relativeTime,
        style = MaterialTheme.typography.bodySmall,
        color = MaterialTheme.colorScheme.secondary
    )
}

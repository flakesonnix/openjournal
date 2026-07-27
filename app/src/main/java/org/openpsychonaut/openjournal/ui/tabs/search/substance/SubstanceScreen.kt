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

package org.openpsychonaut.openjournal.ui.tabs.search.substance

import android.content.res.Configuration.UI_MODE_NIGHT_YES
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.Arrangement
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
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ChevronRight
import androidx.compose.material.icons.filled.GppBad
import androidx.compose.material.icons.filled.OpenInBrowser
import androidx.compose.material.icons.filled.Update
import androidx.compose.material.icons.outlined.AutoAwesome
import androidx.compose.material.icons.outlined.Info
import androidx.compose.material.icons.outlined.Medication
import androidx.compose.material.icons.outlined.Scale
import androidx.compose.material.icons.outlined.Shield
import androidx.compose.material.icons.outlined.Timer
import androidx.compose.material.icons.outlined.Warning
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ElevatedCard
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import org.openpsychonaut.openjournal.data.room.experiences.entities.CustomUnit
import org.openpsychonaut.openjournal.data.substances.AdministrationRoute
import org.openpsychonaut.openjournal.data.substances.classes.Category
import org.openpsychonaut.openjournal.data.substances.classes.SubstanceWithCategories
import org.openpsychonaut.openjournal.ui.DOSE_DISCLAIMER
import org.openpsychonaut.openjournal.ui.FULL_STOMACH_DISCLAIMER
import org.openpsychonaut.openjournal.ui.tabs.journal.addingestion.dose.ChasingTheDragonText
import org.openpsychonaut.openjournal.ui.tabs.journal.addingestion.dose.OptionalDosageUnitDisclaimer
import org.openpsychonaut.openjournal.ui.tabs.journal.addingestion.dose.customunit.CustomUnitRoaDoseView
import org.openpsychonaut.openjournal.ui.tabs.journal.addingestion.time.TimePickerButton
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.TimelineDisplayOption
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.components.TimeDisplayOption
import org.openpsychonaut.openjournal.ui.tabs.journal.experience.timeline.AllTimelines
import org.openpsychonaut.openjournal.ui.tabs.search.substance.roa.ToleranceSection
import org.openpsychonaut.openjournal.ui.tabs.search.substance.roa.dose.RoaDoseView
import org.openpsychonaut.openjournal.ui.tabs.search.substance.roa.duration.RoaDurationView
import org.openpsychonaut.openjournal.ui.tabs.search.substance.roa.toReadableString
import org.openpsychonaut.openjournal.ui.theme.OpenJournalTheme
import org.openpsychonaut.openjournal.ui.theme.horizontalPadding
import org.openpsychonaut.openjournal.ui.utils.getShortTimeText
import java.time.LocalDateTime
import java.time.temporal.ChronoUnit
import kotlin.math.absoluteValue

@Composable
fun SubstanceScreen(
    navigateToDosageExplanationScreen: () -> Unit,
    navigateToSaferHallucinogensScreen: () -> Unit,
    navigateToSaferStimulantsScreen: () -> Unit,
    navigateToVolumetricDosingScreen: () -> Unit,
    navigateToExplainTimeline: () -> Unit,
    navigateToCategoryScreen: (categoryName: String) -> Unit,
    viewModel: SubstanceViewModel = hiltViewModel()
) {
    SubstanceScreen(
        timelineDisplayOption = viewModel.timelineDisplayOptionFlow.collectAsState().value,
        ingestionTime = viewModel.ingestionTimeFlow.collectAsState().value,
        onChangeIngestionTime = viewModel::changeIngestionTime,
        navigateToDosageExplanationScreen = navigateToDosageExplanationScreen,
        navigateToSaferHallucinogensScreen = navigateToSaferHallucinogensScreen,
        navigateToSaferStimulantsScreen = navigateToSaferStimulantsScreen,
        navigateToVolumetricDosingScreen = navigateToVolumetricDosingScreen,
        navigateToCategoryScreen = navigateToCategoryScreen,
        navigateToExplainTimeline = navigateToExplainTimeline,
        substanceWithCategories = viewModel.substanceWithCategories,
        customUnits = viewModel.customUnitsFlow.collectAsState().value,
    )
}

@Preview(uiMode = UI_MODE_NIGHT_YES)
@Composable
fun SubstanceScreenPreview(
    @PreviewParameter(SubstanceWithCategoriesPreviewProvider::class) substanceWithCategories: SubstanceWithCategories
) {
    OpenJournalTheme {
        SubstanceScreen(
            timelineDisplayOption = TimelineDisplayOption.Loading,
            ingestionTime = LocalDateTime.now(),
            onChangeIngestionTime = {},
            navigateToDosageExplanationScreen = {},
            navigateToSaferHallucinogensScreen = {},
            navigateToSaferStimulantsScreen = {},
            navigateToVolumetricDosingScreen = {},
            navigateToExplainTimeline = {},
            navigateToCategoryScreen = {},
            substanceWithCategories = substanceWithCategories,
            customUnits = listOf(
                CustomUnit.mdmaSample
            ),
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class, ExperimentalLayoutApi::class)
@Composable
fun SubstanceScreen(
    timelineDisplayOption: TimelineDisplayOption,
    ingestionTime: LocalDateTime,
    onChangeIngestionTime: (LocalDateTime) -> Unit,
    navigateToDosageExplanationScreen: () -> Unit,
    navigateToSaferHallucinogensScreen: () -> Unit,
    navigateToSaferStimulantsScreen: () -> Unit,
    navigateToVolumetricDosingScreen: () -> Unit,
    navigateToExplainTimeline: () -> Unit,
    navigateToCategoryScreen: (categoryName: String) -> Unit,
    substanceWithCategories: SubstanceWithCategories,
    customUnits: List<CustomUnit>
) {
    val substance = substanceWithCategories.substance
    val uriHandler = LocalUriHandler.current
    Scaffold(
        topBar = {
            TopAppBar(
                title = { 
                    Text(
                        substance.name,
                        style = MaterialTheme.typography.headlineMedium,
                        fontWeight = FontWeight.Bold
                    ) 
                },
                actions = {
                    IconButton(onClick = { uriHandler.openUri(substance.url) }) {
                        Icon(Icons.Default.OpenInBrowser, contentDescription = "Open PsychonautWiki")
                    }
                }
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .verticalScroll(rememberScrollState())
                .padding(padding)
                .padding(bottom = 80.dp)
        ) {
            if (!substance.isApproved) {
                ElevatedCard(
                    modifier = Modifier
                        .padding(horizontal = horizontalPadding, vertical = 8.dp)
                        .fillMaxWidth(),
                    colors = CardDefaults.elevatedCardColors(
                        containerColor = MaterialTheme.colorScheme.errorContainer,
                        contentColor = MaterialTheme.colorScheme.onErrorContainer
                    )
                ) {
                    Row(
                        modifier = Modifier.padding(16.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Icon(imageVector = Icons.Default.GppBad, contentDescription = "Warning")
                        Spacer(Modifier.width(12.dp))
                        Text(
                            text = "Info is not verified by PsychonautWiki",
                            style = MaterialTheme.typography.labelLarge
                        )
                    }
                }
            }
            
            val categories = substanceWithCategories.categories
            if (substance.summary != null || categories.isNotEmpty()) {
                ElevatedCard(
                    modifier = Modifier.padding(horizontal = horizontalPadding, vertical = 8.dp),
                    shape = RoundedCornerShape(24.dp)
                ) {
                    Column(
                        modifier = Modifier
                            .padding(16.dp)
                            .fillMaxWidth()
                    ) {
                        if (substance.summary != null) {
                            Text(
                                text = substance.summary,
                                style = MaterialTheme.typography.bodyLarge,
                                lineHeight = 24.sp
                            )
                            Spacer(modifier = Modifier.height(16.dp))
                        }
                        FlowRow(
                            horizontalArrangement = Arrangement.spacedBy(8.dp),
                            verticalArrangement = Arrangement.spacedBy(8.dp),
                        ) {
                            categories.forEach { category ->
                                CategoryChipFromSubstanceScreen(category, navigateToCategoryScreen)
                            }
                        }
                    }
                }
            }

            val roasWithDosesDefined = substance.roas.filter { roa ->
                val roaDose = roa.roaDose
                roaDose?.lightMin != null || roaDose?.commonMin != null || roaDose?.strongMin != null || roaDose?.heavyMin != null
            }

            if (substance.dosageRemark != null || roasWithDosesDefined.isNotEmpty()) {
                ModernSection(title = "Dosage", icon = Icons.Outlined.Medication) {
                    Column {
                        if (substance.dosageRemark != null) {
                            Text(
                                text = substance.dosageRemark,
                                style = MaterialTheme.typography.bodyMedium,
                                fontStyle = FontStyle.Italic,
                                modifier = Modifier.padding(bottom = 12.dp)
                            )
                            HorizontalDivider()
                        }
                        roasWithDosesDefined.forEachIndexed { index, roa ->
                            Column(modifier = Modifier.padding(vertical = 12.dp)) {
                                Text(
                                    text = roa.route.displayText,
                                    style = MaterialTheme.typography.titleMedium,
                                    fontWeight = FontWeight.Bold,
                                    color = MaterialTheme.colorScheme.primary
                                )
                                Spacer(modifier = Modifier.height(8.dp))
                                if (roa.roaDose == null) {
                                    Text(text = "No dosage info available", style = MaterialTheme.typography.bodyMedium)
                                } else {
                                    RoaDoseView(roaDose = roa.roaDose)
                                }
                                
                                roa.roaDose?.let { roaDose ->
                                    val customUnitsForRoute = customUnits.filter { it.administrationRoute == roa.route && it.dose != null }
                                    customUnitsForRoute.forEach { customUnit ->
                                        Spacer(modifier = Modifier.height(8.dp))
                                        Text(text = customUnit.name, style = MaterialTheme.typography.labelLarge)
                                        CustomUnitRoaDoseView(roaDose = roaDose, customUnit = customUnit)
                                    }
                                }

                                roa.bioavailability?.let { bio ->
                                    Spacer(modifier = Modifier.height(8.dp))
                                    Text(
                                        text = "Bioavailability: ${bio.min?.toReadableString() ?: ".."}-${bio.max?.toReadableString() ?: ".."}%",
                                        style = MaterialTheme.typography.labelMedium,
                                        color = MaterialTheme.colorScheme.secondary
                                    )
                                }

                                if (roa.route == AdministrationRoute.SMOKED && substance.name != "Cannabis") {
                                    Spacer(modifier = Modifier.height(8.dp))
                                    ChasingTheDragonText(titleStyle = MaterialTheme.typography.titleSmall)
                                }
                            }
                            if (index < roasWithDosesDefined.size - 1) HorizontalDivider()
                        }
                        
                        Spacer(modifier = Modifier.height(16.dp))
                        Text(
                            text = DOSE_DISCLAIMER,
                            style = MaterialTheme.typography.bodySmall,
                            color = MaterialTheme.colorScheme.error
                        )
                        
                        Row(modifier = Modifier.padding(top = 8.dp)) {
                            if (substance.roas.any { it.roaDose?.shouldUseVolumetricDosing == true }) {
                                TextButton(onClick = navigateToVolumetricDosingScreen) {
                                    Icon(Icons.Outlined.Info, contentDescription = null, modifier = Modifier.size(18.dp))
                                    Spacer(Modifier.width(4.dp))
                                    Text("Volumetric Dosing")
                                }
                            }
                            TextButton(onClick = navigateToDosageExplanationScreen) {
                                Icon(Icons.Outlined.Info, contentDescription = null, modifier = Modifier.size(18.dp))
                                Spacer(Modifier.width(4.dp))
                                Text("Classifications")
                            }
                        }
                    }
                }
            }

            if (substance.tolerance != null || substance.crossTolerances.isNotEmpty()) {
                ModernSection(title = "Tolerance", icon = Icons.Outlined.Scale) {
                    ToleranceSection(
                        tolerance = substance.tolerance,
                        crossTolerances = substance.crossTolerances
                    )
                }
            }

            val roasWithDurationsDefined = substance.roas.filter { roa ->
                val d = roa.roaDuration
                d?.onset != null || d?.comeup != null || d?.peak != null || d?.offset != null || d?.total != null
            }

            if (roasWithDurationsDefined.isNotEmpty()) {
                ModernSection(title = "Timeline", icon = Icons.Outlined.Timer) {
                    Column {
                        Row(
                            verticalAlignment = Alignment.CenterVertically,
                            modifier = Modifier.fillMaxWidth()
                        ) {
                            Text("Preview from:", style = MaterialTheme.typography.labelLarge)
                            Spacer(Modifier.width(8.dp))
                            TimePickerButton(
                                localDateTime = ingestionTime,
                                onChange = onChangeIngestionTime,
                                timeString = ingestionTime.getShortTimeText(),
                                hasOutline = true,
                            )
                            Spacer(Modifier.weight(1f))
                            IconButton(onClick = navigateToExplainTimeline) {
                                Icon(Icons.Outlined.Info, contentDescription = "Info")
                            }
                        }
                        
                        VerticalSpace()
                        
                        when (timelineDisplayOption) {
                            is TimelineDisplayOption.Shown -> {
                                AllTimelines(
                                    model = timelineDisplayOption.allTimelinesModel,
                                    isShowingCurrentTime = false,
                                    timeDisplayOption = TimeDisplayOption.RELATIVE_TO_NOW,
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .height(180.dp)
                                        .clip(RoundedCornerShape(12.dp))
                                        .background(MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.3f))
                                )
                            }
                            TimelineDisplayOption.Loading -> LinearProgressIndicator(modifier = Modifier.fillMaxWidth())
                            else -> {}
                        }
                        
                        Spacer(modifier = Modifier.height(16.dp))
                        
                        roasWithDurationsDefined.forEachIndexed { index, roa ->
                            Column(modifier = Modifier.padding(vertical = 8.dp)) {
                                Row(verticalAlignment = Alignment.CenterVertically) {
                                    RouteColorCircle(roa.route)
                                    Spacer(Modifier.width(8.dp))
                                    Text(text = roa.route.displayText, style = MaterialTheme.typography.titleSmall)
                                }
                                roa.roaDuration?.let { 
                                    RoaDurationView(roaDuration = it)
                                    if (roa.route == AdministrationRoute.ORAL) {
                                        Text(
                                            text = FULL_STOMACH_DISCLAIMER,
                                            style = MaterialTheme.typography.labelSmall,
                                            color = MaterialTheme.colorScheme.secondary
                                        )
                                    }
                                }
                            }
                            if (index < roasWithDurationsDefined.size - 1) HorizontalDivider()
                        }
                    }
                }
            }

            if (substance.interactions != null) {
                val inter = substance.interactions!!
                if (inter.dangerous.isNotEmpty() || inter.unsafe.isNotEmpty() || inter.uncertain.isNotEmpty()) {
                    ModernSection(title = "Interactions", icon = Icons.Outlined.Warning) {
                        InteractionsView(interactions = inter, substanceURL = substance.url)
                    }
                }
            }

            if (substance.effectsSummary != null) {
                ModernSection(title = "Effects", icon = Icons.Outlined.AutoAwesome) {
                    Text(text = substance.effectsSummary!!, style = MaterialTheme.typography.bodyMedium)
                }
            }

            if (substance.saferUse.isNotEmpty()) {
                ModernSection(title = "Safer Use", icon = Icons.Outlined.Shield) {
                    BulletPoints(points = substance.saferUse)
                }
            }

            Spacer(modifier = Modifier.height(16.dp))
        }
    }
}

@Composable
fun ModernSection(
    title: String,
    icon: ImageVector,
    content: @Composable () -> Unit
) {
    ElevatedCard(
        modifier = Modifier
            .padding(horizontal = horizontalPadding, vertical = 8.dp)
            .fillMaxWidth(),
        shape = RoundedCornerShape(24.dp)
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Icon(
                    imageVector = icon,
                    contentDescription = null,
                    tint = MaterialTheme.colorScheme.primary,
                    modifier = Modifier.size(20.dp)
                )
                Spacer(Modifier.width(12.dp))
                Text(
                    text = title,
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Bold,
                    color = MaterialTheme.colorScheme.primary
                )
            }
            Spacer(Modifier.height(12.dp))
            content()
        }
    }
}

@Composable
fun BulletPoints(points: List<String>, modifier: Modifier = Modifier) {
    Column(modifier = modifier, verticalArrangement = Arrangement.spacedBy(8.dp)) {
        points.forEach {
            Row(verticalAlignment = Alignment.Top) {
                Text(text = "•", style = MaterialTheme.typography.bodyLarge, color = MaterialTheme.colorScheme.primary)
                Spacer(modifier = Modifier.width(8.dp))
                Text(text = it, style = MaterialTheme.typography.bodyMedium)
            }
        }
    }
}

@Composable
fun VerticalSpace() {
    Spacer(modifier = Modifier.height(8.dp))
}

@Composable
fun CategoryChipFromSubstanceScreen(
    category: Category,
    navigateToCategoryScreen: (categoryName: String) -> Unit
) {
    Surface(
        onClick = { navigateToCategoryScreen(category.name) },
        shape = CircleShape,
        color = MaterialTheme.colorScheme.secondaryContainer.copy(alpha = 0.5f),
        modifier = Modifier.height(32.dp)
    ) {
        Row(
            modifier = Modifier.padding(horizontal = 12.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(text = category.name, style = MaterialTheme.typography.labelMedium)
            Icon(Icons.Default.ChevronRight, contentDescription = null, modifier = Modifier.size(16.dp))
        }
    }
}


@Composable
fun RouteColorCircle(administrationRoute: AdministrationRoute) {
    val isDarkTheme = isSystemInDarkTheme()
    Surface(
        shape = CircleShape,
        color = administrationRoute.color.getComposeColor(isDarkTheme),
        modifier = Modifier
            .size(20.dp)
    ) {}
}

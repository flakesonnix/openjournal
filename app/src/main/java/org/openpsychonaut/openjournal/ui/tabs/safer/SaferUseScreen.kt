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

package org.openpsychonaut.openjournal.ui.tabs.safer

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
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
import androidx.compose.material.icons.filled.ChevronRight
import androidx.compose.material.icons.filled.OpenInBrowser
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material.icons.outlined.AutoAwesome
import androidx.compose.material.icons.outlined.Biotech
import androidx.compose.material.icons.outlined.Book
import androidx.compose.material.icons.outlined.HealthAndSafety
import androidx.compose.material.icons.outlined.Info
import androidx.compose.material.icons.outlined.Medication
import androidx.compose.material.icons.outlined.Scale
import androidx.compose.material.icons.outlined.Science
import androidx.compose.material.icons.outlined.Shield
import androidx.compose.material.icons.outlined.Visibility
import androidx.compose.material.icons.outlined.Warning
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ElevatedCard
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalUriHandler
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import org.openpsychonaut.openjournal.ui.theme.OpenJournalTheme
import org.openpsychonaut.openjournal.ui.theme.horizontalPadding
import org.openpsychonaut.openjournal.ui.theme.verticalPaddingCards

@Preview
@Composable
fun SaferUsePreview() {
    SaferUseScreen(
        navigateToDrugTestingScreen = {},
        navigateToSaferHallucinogensScreen = {},
        navigateToVolumetricDosingScreen = {},
        navigateToDosageGuideScreen = {},
        navigateToDosageClassificationScreen = {},
        navigateToRouteExplanationScreen = {},
        navigateToReagentTestingScreen = {},
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SaferUseScreen(
    navigateToDrugTestingScreen: () -> Unit,
    navigateToSaferHallucinogensScreen: () -> Unit,
    navigateToVolumetricDosingScreen: () -> Unit,
    navigateToDosageGuideScreen: () -> Unit,
    navigateToDosageClassificationScreen: () -> Unit,
    navigateToRouteExplanationScreen: () -> Unit,
    navigateToReagentTestingScreen: () -> Unit,
) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { 
                    Text(
                        "Harm Reduction",
                        style = MaterialTheme.typography.headlineMedium,
                        fontWeight = FontWeight.Bold
                    ) 
                },
            )
        },
    ) { padding ->
        Column(
            Modifier
                .verticalScroll(rememberScrollState())
                .padding(padding)
                .padding(bottom = 32.dp)
        ) {
            SaferCard(
                title = "1. Research",
                icon = Icons.Outlined.Visibility,
                description = "In advance research the duration, subjective effects and potential adverse effects which the substance or combination of substances are likely to produce.\n\nRead the info in here and also the PsychonautWiki article. Its best to cross-reference with other sources (Tripsit, Erowid, Wikipedia, Bluelight, Reddit, etc)."
            )

            SaferCard(
                title = "2. Testing",
                icon = Icons.Outlined.Science,
                description = "Test your substance with anonymous and free drug testing services. If those are not available in your country, use reagent testing kits. Don‘t trust your dealer to sell reliable product."
            ) {
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    TextButton(onClick = navigateToDrugTestingScreen) {
                        Icon(Icons.Outlined.Biotech, contentDescription = null, modifier = Modifier.size(18.dp))
                        Spacer(Modifier.width(4.dp))
                        Text("Lab Services")
                    }
                    TextButton(onClick = navigateToReagentTestingScreen) {
                        Icon(Icons.Outlined.Science, contentDescription = null, modifier = Modifier.size(18.dp))
                        Spacer(Modifier.width(4.dp))
                        Text("Reagents")
                    }
                }
            }

            SaferCard(
                title = "3. Dosage",
                icon = Icons.Outlined.Scale,
                description = "Know your dose, start small and wait. A full stomach can delay onset by hours. Invest in a milligram scale. If amounts are very small, use volumetric dosing."
            ) {
                Column {
                    TextButton(onClick = navigateToDosageGuideScreen) {
                        Text("View Dosage Guide")
                        Icon(Icons.Default.ChevronRight, contentDescription = null)
                    }
                    TextButton(onClick = navigateToDosageClassificationScreen) {
                        Text("Dosage Classifications")
                        Icon(Icons.Default.ChevronRight, contentDescription = null)
                    }
                    TextButton(onClick = navigateToVolumetricDosingScreen) {
                        Text("Volumetric Liquid Dosing")
                        Icon(Icons.Default.ChevronRight, contentDescription = null)
                    }
                }
            }

            SaferCard(
                title = "4. Set and Setting",
                icon = Icons.Outlined.HealthAndSafety,
                description = "Set: Ensure your mood and expectations are conducive to a safe experience. Be physically well.\n\nSetting: Choose a sense of safety, familiarity, control, and comfort."
            ) {
                Button(onClick = navigateToSaferHallucinogensScreen) {
                    Text("Hallucinogen Safety Guide")
                }
            }

            SaferCard(
                title = "5. Combinations",
                icon = Icons.Outlined.Warning,
                description = "Don’t combine drugs without research. The most common cause of substance-related deaths is the combination of multiple depressants."
            ) {
                val uriHandler = LocalUriHandler.current
                Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                    TextButton(onClick = { uriHandler.openUri("https://combi-checker.ch") }) {
                        Text("Swiss Checker")
                        Icon(Icons.Default.OpenInBrowser, contentDescription = null, modifier = Modifier.size(16.dp))
                    }
                    TextButton(onClick = { uriHandler.openUri("https://combo.tripsit.me") }) {
                        Text("Tripsit")
                        Icon(Icons.Default.OpenInBrowser, contentDescription = null, modifier = Modifier.size(16.dp))
                    }
                }
            }

            SaferCard(
                title = "6. Administration",
                icon = Icons.Outlined.Medication,
                description = "Don’t share equipment to avoid blood-borne diseases. Injection is highly dangerous and advised against."
            ) {
                TextButton(onClick = navigateToRouteExplanationScreen) {
                    Icon(Icons.Outlined.Info, contentDescription = null, modifier = Modifier.size(18.dp))
                    Spacer(Modifier.width(4.dp))
                    Text("Learn about ROAs")
                }
            }

            SaferCard(
                title = "10. Recovery Position",
                icon = Icons.Outlined.HealthAndSafety,
                description = "If someone is unconscious but breathing, place them in the Recovery Position to prevent suffocation from vomit."
            ) {
                val uriHandler = LocalUriHandler.current
                Button(onClick = { uriHandler.openUri("https://www.youtube.com/watch?v=dv3agW-DZ5I") }) {
                    Icon(Icons.Default.PlayArrow, contentDescription = null)
                    Spacer(Modifier.width(8.dp))
                    Text("Watch Tutorial")
                }
            }

            Spacer(modifier = Modifier.height(16.dp))
            
            val uriHandler = LocalUriHandler.current
            ElevatedCard(
                onClick = { uriHandler.openUri("https://psychonautwiki.org/wiki/Responsible_drug_use") },
                modifier = Modifier
                    .padding(horizontal = horizontalPadding, vertical = 8.dp)
                    .fillMaxWidth(),
                colors = CardDefaults.elevatedCardColors(
                    containerColor = MaterialTheme.colorScheme.primaryContainer,
                    contentColor = MaterialTheme.colorScheme.onPrimaryContainer
                )
            ) {
                Row(
                    modifier = Modifier.padding(16.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Icon(Icons.Outlined.Book, contentDescription = null)
                    Spacer(Modifier.width(12.dp))
                    Text("Read: Responsible Drug Use", fontWeight = FontWeight.Bold)
                    Spacer(Modifier.weight(1f))
                    Icon(Icons.Default.ChevronRight, contentDescription = null)
                }
            }
        }
    }
}

@Composable
fun SaferCard(
    title: String,
    icon: ImageVector,
    description: String,
    content: @Composable (() -> Unit)? = null
) {
    ElevatedCard(
        modifier = Modifier
            .padding(horizontal = horizontalPadding, vertical = 8.dp)
            .fillMaxWidth(),
        shape = RoundedCornerShape(20.dp)
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Icon(icon, contentDescription = null, tint = MaterialTheme.colorScheme.primary)
                Spacer(Modifier.width(12.dp))
                Text(
                    text = title,
                    style = MaterialTheme.typography.titleLarge,
                    fontWeight = FontWeight.Bold
                )
            }
            Spacer(Modifier.height(8.dp))
            Text(
                text = description,
                style = MaterialTheme.typography.bodyMedium,
                lineHeight = 22.sp
            )
            if (content != null) {
                Spacer(Modifier.height(12.dp))
                content()
            }
        }
    }
}

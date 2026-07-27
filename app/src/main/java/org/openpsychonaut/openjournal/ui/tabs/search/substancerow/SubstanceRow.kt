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

package org.openpsychonaut.openjournal.ui.tabs.search.substancerow

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.ListItem
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.tooling.preview.PreviewParameter
import androidx.compose.ui.unit.dp
import org.openpsychonaut.openjournal.ui.tabs.search.CategoryModel
import org.openpsychonaut.openjournal.ui.tabs.search.SubstanceModel

@Preview(showBackground = true)
@Composable
fun SubstanceRowPreview(
    @PreviewParameter(SubstanceModelPreviewProvider::class) substanceModel: SubstanceModel
) {
    SubstanceRow(substanceModel = substanceModel, onTap = {})
}

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun SubstanceRow(
    substanceModel: SubstanceModel,
    onTap: (substanceName: String) -> Unit
) {
    ListItem(
        modifier = Modifier.clickable { onTap(substanceModel.name) },
        headlineContent = {
            Text(
                text = substanceModel.name,
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold
            )
        },
        supportingContent = {
            Column {
                if (substanceModel.commonNames.isNotEmpty()) {
                    Text(
                        text = substanceModel.commonNames.joinToString(", "),
                        style = MaterialTheme.typography.bodySmall,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
                FlowRow(
                    horizontalArrangement = Arrangement.spacedBy(4.dp),
                    verticalArrangement = Arrangement.spacedBy(4.dp),
                    modifier = Modifier.padding(top = 4.dp)
                ) {
                    substanceModel.categories.forEach {
                        CategoryChipStatic(categoryModel = it)
                    }
                }
            }
        }
    )
}

@Composable
fun CategoryChipStatic(categoryModel: CategoryModel) {
    Box(
        modifier = Modifier
            .clip(CircleShape)
            .background(categoryModel.color.copy(alpha = 0.15f))
            .padding(horizontal = 8.dp, vertical = 2.dp)
    ) {
        Text(
            text = categoryModel.name,
            style = MaterialTheme.typography.labelSmall,
            color = categoryModel.color.copy(alpha = 0.9f)
        )
    }
}

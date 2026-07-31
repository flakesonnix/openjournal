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
 * along with PsychonautWiki Journal.  If not, see https://www.gnu.org/licenses/gpl-3.0.en.html.
 */

package org.openpsychonaut.openjournal.ui.security

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.unit.dp
import kotlin.math.pow
import kotlin.math.sqrt

@Composable
fun PatternLockView(
    modifier: Modifier = Modifier,
    onPatternComplete: (String) -> Unit
) {
    var points by remember { mutableStateOf(emptyList<Int>()) }
    var currentTouchPoint by remember { mutableStateOf<Offset?>(null) }
    val dotRadius = 12.dp
    val hitRadius = 40.dp
    val primaryColor = MaterialTheme.colorScheme.primary
    val onSurfaceColor = MaterialTheme.colorScheme.onSurface

    Box(
        modifier = modifier
            .aspectRatio(1f)
            .padding(32.dp)
    ) {
        Canvas(
            modifier = Modifier
                .fillMaxSize()
                .pointerInput(Unit) {
                    detectDragGestures(
                        onDragStart = { offset ->
                            points = emptyList()
                            currentTouchPoint = offset
                        },
                        onDrag = { change, _ ->
                            currentTouchPoint = change.position
                        },
                        onDragEnd = {
                            if (points.isNotEmpty()) {
                                onPatternComplete(points.joinToString(","))
                            }
                            points = emptyList()
                            currentTouchPoint = null
                        },
                        onDragCancel = {
                            points = emptyList()
                            currentTouchPoint = null
                        }
                    )
                }
        ) {
            val canvasSize = size
            val cellWidth = canvasSize.width / 3
            val cellHeight = canvasSize.height / 3

            val gridPoints = List(9) { index ->
                val col = index % 3
                val row = index / 3
                Offset(
                    x = col * cellWidth + cellWidth / 2,
                    y = row * cellHeight + cellHeight / 2
                )
            }

            // Check for new points
            currentTouchPoint?.let { touch ->
                gridPoints.forEachIndexed { index, point ->
                    val distance = sqrt((touch.x - point.x).pow(2) + (touch.y - point.y).pow(2))
                    if (distance < hitRadius.toPx() && !points.contains(index)) {
                        points = points + index
                    }
                }
            }

            // Draw connections
            if (points.isNotEmpty()) {
                for (i in 0 until points.size - 1) {
                    drawLine(
                        color = primaryColor,
                        start = gridPoints[points[i]],
                        end = gridPoints[points[i + 1]],
                        strokeWidth = 8.dp.toPx(),
                        cap = StrokeCap.Round
                    )
                }
                currentTouchPoint?.let { touch ->
                    drawLine(
                        color = primaryColor,
                        start = gridPoints[points.last()],
                        end = touch,
                        strokeWidth = 8.dp.toPx(),
                        cap = StrokeCap.Round
                    )
                }
            }

            // Draw dots
            gridPoints.forEachIndexed { index, point ->
                val isSelected = points.contains(index)
                drawCircle(
                    color = if (isSelected) primaryColor else onSurfaceColor.copy(alpha = 0.3f),
                    radius = if (isSelected) (dotRadius * 1.5f).toPx() else dotRadius.toPx(),
                    center = point
                )
            }
        }
    }
}

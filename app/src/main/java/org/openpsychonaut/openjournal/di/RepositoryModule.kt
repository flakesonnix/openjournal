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

package org.openpsychonaut.openjournal.di

import org.openpsychonaut.openjournal.data.substances.parse.SubstanceParser
import org.openpsychonaut.openjournal.data.substances.parse.SubstanceParserInterface
import org.openpsychonaut.openjournal.data.substances.repositories.SearchRepository
import org.openpsychonaut.openjournal.data.substances.repositories.SearchRepositoryInterface
import org.openpsychonaut.openjournal.data.substances.repositories.SubstanceRepository
import org.openpsychonaut.openjournal.data.substances.repositories.SubstanceRepositoryInterface
import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
abstract class RepositoryModule {

    @Binds
    @Singleton
    abstract fun bindSubstanceParser(
        substanceParser: SubstanceParser
    ): SubstanceParserInterface

    @Binds
    @Singleton
    abstract fun bindSubstanceRepository(
        substanceRepository: SubstanceRepository
    ): SubstanceRepositoryInterface

    @Binds
    @Singleton
    abstract fun bindSearchRepository(
        substanceRepository: SearchRepository
    ): SearchRepositoryInterface
}
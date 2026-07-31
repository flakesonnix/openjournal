// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// ignore_for_file: type=lint
class $ExperiencesTable extends Experiences
    with TableInfo<$ExperiencesTable, Experience> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExperiencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationDateMeta = const VerificationMeta(
    'creationDate',
  );
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
    'creation_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortDateMeta = const VerificationMeta(
    'sortDate',
  );
  @override
  late final GeneratedColumn<DateTime> sortDate = GeneratedColumn<DateTime>(
    'sort_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
  );
  static const VerificationMeta _locationNameMeta = const VerificationMeta(
    'locationName',
  );
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    textContent,
    creationDate,
    sortDate,
    isFavorite,
    locationName,
    longitude,
    latitude,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'experiences';
  @override
  VerificationContext validateIntegrity(
    Insertable<Experience> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(data['text']!, _textContentMeta),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('creation_date')) {
      context.handle(
        _creationDateMeta,
        creationDate.isAcceptableOrUnknown(
          data['creation_date']!,
          _creationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    if (data.containsKey('sort_date')) {
      context.handle(
        _sortDateMeta,
        sortDate.isAcceptableOrUnknown(data['sort_date']!, _sortDateMeta),
      );
    } else if (isInserting) {
      context.missing(_sortDateMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _locationNameMeta,
        locationName.isAcceptableOrUnknown(data['name']!, _locationNameMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Experience map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Experience(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      creationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_date'],
      )!,
      sortDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sort_date'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      locationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
    );
  }

  @override
  $ExperiencesTable createAlias(String alias) {
    return $ExperiencesTable(attachedDatabase, alias);
  }
}

class Experience extends DataClass implements Insertable<Experience> {
  final int id;
  final String title;
  final String textContent;
  final DateTime creationDate;
  final DateTime sortDate;
  final bool isFavorite;
  final String? locationName;
  final double? longitude;
  final double? latitude;
  const Experience({
    required this.id,
    required this.title,
    required this.textContent,
    required this.creationDate,
    required this.sortDate,
    required this.isFavorite,
    this.locationName,
    this.longitude,
    this.latitude,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['text'] = Variable<String>(textContent);
    map['creation_date'] = Variable<DateTime>(creationDate);
    map['sort_date'] = Variable<DateTime>(sortDate);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || locationName != null) {
      map['name'] = Variable<String>(locationName);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    return map;
  }

  ExperiencesCompanion toCompanion(bool nullToAbsent) {
    return ExperiencesCompanion(
      id: Value(id),
      title: Value(title),
      textContent: Value(textContent),
      creationDate: Value(creationDate),
      sortDate: Value(sortDate),
      isFavorite: Value(isFavorite),
      locationName: locationName == null && nullToAbsent
          ? const Value.absent()
          : Value(locationName),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
    );
  }

  factory Experience.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Experience(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      textContent: serializer.fromJson<String>(json['textContent']),
      creationDate: serializer.fromJson<DateTime>(json['creationDate']),
      sortDate: serializer.fromJson<DateTime>(json['sortDate']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      locationName: serializer.fromJson<String?>(json['locationName']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      latitude: serializer.fromJson<double?>(json['latitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'textContent': serializer.toJson<String>(textContent),
      'creationDate': serializer.toJson<DateTime>(creationDate),
      'sortDate': serializer.toJson<DateTime>(sortDate),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'locationName': serializer.toJson<String?>(locationName),
      'longitude': serializer.toJson<double?>(longitude),
      'latitude': serializer.toJson<double?>(latitude),
    };
  }

  Experience copyWith({
    int? id,
    String? title,
    String? textContent,
    DateTime? creationDate,
    DateTime? sortDate,
    bool? isFavorite,
    Value<String?> locationName = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
  }) => Experience(
    id: id ?? this.id,
    title: title ?? this.title,
    textContent: textContent ?? this.textContent,
    creationDate: creationDate ?? this.creationDate,
    sortDate: sortDate ?? this.sortDate,
    isFavorite: isFavorite ?? this.isFavorite,
    locationName: locationName.present ? locationName.value : this.locationName,
    longitude: longitude.present ? longitude.value : this.longitude,
    latitude: latitude.present ? latitude.value : this.latitude,
  );
  Experience copyWithCompanion(ExperiencesCompanion data) {
    return Experience(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      creationDate: data.creationDate.present
          ? data.creationDate.value
          : this.creationDate,
      sortDate: data.sortDate.present ? data.sortDate.value : this.sortDate,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Experience(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('textContent: $textContent, ')
          ..write('creationDate: $creationDate, ')
          ..write('sortDate: $sortDate, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('locationName: $locationName, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    textContent,
    creationDate,
    sortDate,
    isFavorite,
    locationName,
    longitude,
    latitude,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Experience &&
          other.id == this.id &&
          other.title == this.title &&
          other.textContent == this.textContent &&
          other.creationDate == this.creationDate &&
          other.sortDate == this.sortDate &&
          other.isFavorite == this.isFavorite &&
          other.locationName == this.locationName &&
          other.longitude == this.longitude &&
          other.latitude == this.latitude);
}

class ExperiencesCompanion extends UpdateCompanion<Experience> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> textContent;
  final Value<DateTime> creationDate;
  final Value<DateTime> sortDate;
  final Value<bool> isFavorite;
  final Value<String?> locationName;
  final Value<double?> longitude;
  final Value<double?> latitude;
  const ExperiencesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.textContent = const Value.absent(),
    this.creationDate = const Value.absent(),
    this.sortDate = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.locationName = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
  });
  ExperiencesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String textContent,
    required DateTime creationDate,
    required DateTime sortDate,
    required bool isFavorite,
    this.locationName = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
  }) : title = Value(title),
       textContent = Value(textContent),
       creationDate = Value(creationDate),
       sortDate = Value(sortDate),
       isFavorite = Value(isFavorite);
  static Insertable<Experience> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? textContent,
    Expression<DateTime>? creationDate,
    Expression<DateTime>? sortDate,
    Expression<bool>? isFavorite,
    Expression<String>? locationName,
    Expression<double>? longitude,
    Expression<double>? latitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (textContent != null) 'text': textContent,
      if (creationDate != null) 'creation_date': creationDate,
      if (sortDate != null) 'sort_date': sortDate,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (locationName != null) 'name': locationName,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
    });
  }

  ExperiencesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? textContent,
    Value<DateTime>? creationDate,
    Value<DateTime>? sortDate,
    Value<bool>? isFavorite,
    Value<String?>? locationName,
    Value<double?>? longitude,
    Value<double?>? latitude,
  }) {
    return ExperiencesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      textContent: textContent ?? this.textContent,
      creationDate: creationDate ?? this.creationDate,
      sortDate: sortDate ?? this.sortDate,
      isFavorite: isFavorite ?? this.isFavorite,
      locationName: locationName ?? this.locationName,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (textContent.present) {
      map['text'] = Variable<String>(textContent.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    if (sortDate.present) {
      map['sort_date'] = Variable<DateTime>(sortDate.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (locationName.present) {
      map['name'] = Variable<String>(locationName.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExperiencesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('textContent: $textContent, ')
          ..write('creationDate: $creationDate, ')
          ..write('sortDate: $sortDate, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('locationName: $locationName, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude')
          ..write(')'))
        .toString();
  }
}

class $IngestionsTable extends Ingestions
    with TableInfo<$IngestionsTable, Ingestion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _substanceNameMeta = const VerificationMeta(
    'substanceName',
  );
  @override
  late final GeneratedColumn<String> substanceName = GeneratedColumn<String>(
    'substance_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creationDateMeta = const VerificationMeta(
    'creationDate',
  );
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
    'creation_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _administrationRouteMeta =
      const VerificationMeta('administrationRoute');
  @override
  late final GeneratedColumn<String> administrationRoute =
      GeneratedColumn<String>(
        'administration_route',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _doseMeta = const VerificationMeta('dose');
  @override
  late final GeneratedColumn<double> dose = GeneratedColumn<double>(
    'dose',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDoseAnEstimateMeta = const VerificationMeta(
    'isDoseAnEstimate',
  );
  @override
  late final GeneratedColumn<bool> isDoseAnEstimate = GeneratedColumn<bool>(
    'is_dose_an_estimate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dose_an_estimate" IN (0, 1))',
    ),
  );
  static const VerificationMeta _estimatedDoseStandardDeviationMeta =
      const VerificationMeta('estimatedDoseStandardDeviation');
  @override
  late final GeneratedColumn<double> estimatedDoseStandardDeviation =
      GeneratedColumn<double>(
        'estimated_dose_standard_deviation',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _unitsMeta = const VerificationMeta('units');
  @override
  late final GeneratedColumn<String> units = GeneratedColumn<String>(
    'units',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _experienceIdMeta = const VerificationMeta(
    'experienceId',
  );
  @override
  late final GeneratedColumn<int> experienceId = GeneratedColumn<int>(
    'experience_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES experiences (id)',
    ),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<StomachFullness?, String>
  stomachFullness =
      GeneratedColumn<String>(
        'stomach_fullness',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<StomachFullness?>(
        $IngestionsTable.$converterstomachFullnessn,
      );
  static const VerificationMeta _consumerNameMeta = const VerificationMeta(
    'consumerName',
  );
  @override
  late final GeneratedColumn<String> consumerName = GeneratedColumn<String>(
    'consumer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customUnitIdMeta = const VerificationMeta(
    'customUnitId',
  );
  @override
  late final GeneratedColumn<int> customUnitId = GeneratedColumn<int>(
    'custom_unit_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    substanceName,
    time,
    endTime,
    creationDate,
    administrationRoute,
    dose,
    isDoseAnEstimate,
    estimatedDoseStandardDeviation,
    units,
    experienceId,
    notes,
    stomachFullness,
    consumerName,
    customUnitId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingestions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ingestion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('substance_name')) {
      context.handle(
        _substanceNameMeta,
        substanceName.isAcceptableOrUnknown(
          data['substance_name']!,
          _substanceNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_substanceNameMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('creation_date')) {
      context.handle(
        _creationDateMeta,
        creationDate.isAcceptableOrUnknown(
          data['creation_date']!,
          _creationDateMeta,
        ),
      );
    }
    if (data.containsKey('administration_route')) {
      context.handle(
        _administrationRouteMeta,
        administrationRoute.isAcceptableOrUnknown(
          data['administration_route']!,
          _administrationRouteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_administrationRouteMeta);
    }
    if (data.containsKey('dose')) {
      context.handle(
        _doseMeta,
        dose.isAcceptableOrUnknown(data['dose']!, _doseMeta),
      );
    }
    if (data.containsKey('is_dose_an_estimate')) {
      context.handle(
        _isDoseAnEstimateMeta,
        isDoseAnEstimate.isAcceptableOrUnknown(
          data['is_dose_an_estimate']!,
          _isDoseAnEstimateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isDoseAnEstimateMeta);
    }
    if (data.containsKey('estimated_dose_standard_deviation')) {
      context.handle(
        _estimatedDoseStandardDeviationMeta,
        estimatedDoseStandardDeviation.isAcceptableOrUnknown(
          data['estimated_dose_standard_deviation']!,
          _estimatedDoseStandardDeviationMeta,
        ),
      );
    }
    if (data.containsKey('units')) {
      context.handle(
        _unitsMeta,
        units.isAcceptableOrUnknown(data['units']!, _unitsMeta),
      );
    }
    if (data.containsKey('experience_id')) {
      context.handle(
        _experienceIdMeta,
        experienceId.isAcceptableOrUnknown(
          data['experience_id']!,
          _experienceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_experienceIdMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('consumer_name')) {
      context.handle(
        _consumerNameMeta,
        consumerName.isAcceptableOrUnknown(
          data['consumer_name']!,
          _consumerNameMeta,
        ),
      );
    }
    if (data.containsKey('custom_unit_id')) {
      context.handle(
        _customUnitIdMeta,
        customUnitId.isAcceptableOrUnknown(
          data['custom_unit_id']!,
          _customUnitIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingestion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingestion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      substanceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}substance_name'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      creationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_date'],
      ),
      administrationRoute: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}administration_route'],
      )!,
      dose: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dose'],
      ),
      isDoseAnEstimate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dose_an_estimate'],
      )!,
      estimatedDoseStandardDeviation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_dose_standard_deviation'],
      ),
      units: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}units'],
      ),
      experienceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}experience_id'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      stomachFullness: $IngestionsTable.$converterstomachFullnessn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}stomach_fullness'],
        ),
      ),
      consumerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}consumer_name'],
      ),
      customUnitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}custom_unit_id'],
      ),
    );
  }

  @override
  $IngestionsTable createAlias(String alias) {
    return $IngestionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StomachFullness, String, String>
  $converterstomachFullness = const EnumNameConverter<StomachFullness>(
    StomachFullness.values,
  );
  static JsonTypeConverter2<StomachFullness?, String?, String?>
  $converterstomachFullnessn = JsonTypeConverter2.asNullable(
    $converterstomachFullness,
  );
}

class Ingestion extends DataClass implements Insertable<Ingestion> {
  final int id;
  final String substanceName;
  final DateTime time;
  final DateTime? endTime;
  final DateTime? creationDate;
  final String administrationRoute;
  final double? dose;
  final bool isDoseAnEstimate;
  final double? estimatedDoseStandardDeviation;
  final String? units;
  final int experienceId;
  final String? notes;
  final StomachFullness? stomachFullness;
  final String? consumerName;
  final int? customUnitId;
  const Ingestion({
    required this.id,
    required this.substanceName,
    required this.time,
    this.endTime,
    this.creationDate,
    required this.administrationRoute,
    this.dose,
    required this.isDoseAnEstimate,
    this.estimatedDoseStandardDeviation,
    this.units,
    required this.experienceId,
    this.notes,
    this.stomachFullness,
    this.consumerName,
    this.customUnitId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['substance_name'] = Variable<String>(substanceName);
    map['time'] = Variable<DateTime>(time);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || creationDate != null) {
      map['creation_date'] = Variable<DateTime>(creationDate);
    }
    map['administration_route'] = Variable<String>(administrationRoute);
    if (!nullToAbsent || dose != null) {
      map['dose'] = Variable<double>(dose);
    }
    map['is_dose_an_estimate'] = Variable<bool>(isDoseAnEstimate);
    if (!nullToAbsent || estimatedDoseStandardDeviation != null) {
      map['estimated_dose_standard_deviation'] = Variable<double>(
        estimatedDoseStandardDeviation,
      );
    }
    if (!nullToAbsent || units != null) {
      map['units'] = Variable<String>(units);
    }
    map['experience_id'] = Variable<int>(experienceId);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || stomachFullness != null) {
      map['stomach_fullness'] = Variable<String>(
        $IngestionsTable.$converterstomachFullnessn.toSql(stomachFullness),
      );
    }
    if (!nullToAbsent || consumerName != null) {
      map['consumer_name'] = Variable<String>(consumerName);
    }
    if (!nullToAbsent || customUnitId != null) {
      map['custom_unit_id'] = Variable<int>(customUnitId);
    }
    return map;
  }

  IngestionsCompanion toCompanion(bool nullToAbsent) {
    return IngestionsCompanion(
      id: Value(id),
      substanceName: Value(substanceName),
      time: Value(time),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      creationDate: creationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(creationDate),
      administrationRoute: Value(administrationRoute),
      dose: dose == null && nullToAbsent ? const Value.absent() : Value(dose),
      isDoseAnEstimate: Value(isDoseAnEstimate),
      estimatedDoseStandardDeviation:
          estimatedDoseStandardDeviation == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedDoseStandardDeviation),
      units: units == null && nullToAbsent
          ? const Value.absent()
          : Value(units),
      experienceId: Value(experienceId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      stomachFullness: stomachFullness == null && nullToAbsent
          ? const Value.absent()
          : Value(stomachFullness),
      consumerName: consumerName == null && nullToAbsent
          ? const Value.absent()
          : Value(consumerName),
      customUnitId: customUnitId == null && nullToAbsent
          ? const Value.absent()
          : Value(customUnitId),
    );
  }

  factory Ingestion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingestion(
      id: serializer.fromJson<int>(json['id']),
      substanceName: serializer.fromJson<String>(json['substanceName']),
      time: serializer.fromJson<DateTime>(json['time']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      creationDate: serializer.fromJson<DateTime?>(json['creationDate']),
      administrationRoute: serializer.fromJson<String>(
        json['administrationRoute'],
      ),
      dose: serializer.fromJson<double?>(json['dose']),
      isDoseAnEstimate: serializer.fromJson<bool>(json['isDoseAnEstimate']),
      estimatedDoseStandardDeviation: serializer.fromJson<double?>(
        json['estimatedDoseStandardDeviation'],
      ),
      units: serializer.fromJson<String?>(json['units']),
      experienceId: serializer.fromJson<int>(json['experienceId']),
      notes: serializer.fromJson<String?>(json['notes']),
      stomachFullness: $IngestionsTable.$converterstomachFullnessn.fromJson(
        serializer.fromJson<String?>(json['stomachFullness']),
      ),
      consumerName: serializer.fromJson<String?>(json['consumerName']),
      customUnitId: serializer.fromJson<int?>(json['customUnitId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'substanceName': serializer.toJson<String>(substanceName),
      'time': serializer.toJson<DateTime>(time),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'creationDate': serializer.toJson<DateTime?>(creationDate),
      'administrationRoute': serializer.toJson<String>(administrationRoute),
      'dose': serializer.toJson<double?>(dose),
      'isDoseAnEstimate': serializer.toJson<bool>(isDoseAnEstimate),
      'estimatedDoseStandardDeviation': serializer.toJson<double?>(
        estimatedDoseStandardDeviation,
      ),
      'units': serializer.toJson<String?>(units),
      'experienceId': serializer.toJson<int>(experienceId),
      'notes': serializer.toJson<String?>(notes),
      'stomachFullness': serializer.toJson<String?>(
        $IngestionsTable.$converterstomachFullnessn.toJson(stomachFullness),
      ),
      'consumerName': serializer.toJson<String?>(consumerName),
      'customUnitId': serializer.toJson<int?>(customUnitId),
    };
  }

  Ingestion copyWith({
    int? id,
    String? substanceName,
    DateTime? time,
    Value<DateTime?> endTime = const Value.absent(),
    Value<DateTime?> creationDate = const Value.absent(),
    String? administrationRoute,
    Value<double?> dose = const Value.absent(),
    bool? isDoseAnEstimate,
    Value<double?> estimatedDoseStandardDeviation = const Value.absent(),
    Value<String?> units = const Value.absent(),
    int? experienceId,
    Value<String?> notes = const Value.absent(),
    Value<StomachFullness?> stomachFullness = const Value.absent(),
    Value<String?> consumerName = const Value.absent(),
    Value<int?> customUnitId = const Value.absent(),
  }) => Ingestion(
    id: id ?? this.id,
    substanceName: substanceName ?? this.substanceName,
    time: time ?? this.time,
    endTime: endTime.present ? endTime.value : this.endTime,
    creationDate: creationDate.present ? creationDate.value : this.creationDate,
    administrationRoute: administrationRoute ?? this.administrationRoute,
    dose: dose.present ? dose.value : this.dose,
    isDoseAnEstimate: isDoseAnEstimate ?? this.isDoseAnEstimate,
    estimatedDoseStandardDeviation: estimatedDoseStandardDeviation.present
        ? estimatedDoseStandardDeviation.value
        : this.estimatedDoseStandardDeviation,
    units: units.present ? units.value : this.units,
    experienceId: experienceId ?? this.experienceId,
    notes: notes.present ? notes.value : this.notes,
    stomachFullness: stomachFullness.present
        ? stomachFullness.value
        : this.stomachFullness,
    consumerName: consumerName.present ? consumerName.value : this.consumerName,
    customUnitId: customUnitId.present ? customUnitId.value : this.customUnitId,
  );
  Ingestion copyWithCompanion(IngestionsCompanion data) {
    return Ingestion(
      id: data.id.present ? data.id.value : this.id,
      substanceName: data.substanceName.present
          ? data.substanceName.value
          : this.substanceName,
      time: data.time.present ? data.time.value : this.time,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      creationDate: data.creationDate.present
          ? data.creationDate.value
          : this.creationDate,
      administrationRoute: data.administrationRoute.present
          ? data.administrationRoute.value
          : this.administrationRoute,
      dose: data.dose.present ? data.dose.value : this.dose,
      isDoseAnEstimate: data.isDoseAnEstimate.present
          ? data.isDoseAnEstimate.value
          : this.isDoseAnEstimate,
      estimatedDoseStandardDeviation:
          data.estimatedDoseStandardDeviation.present
          ? data.estimatedDoseStandardDeviation.value
          : this.estimatedDoseStandardDeviation,
      units: data.units.present ? data.units.value : this.units,
      experienceId: data.experienceId.present
          ? data.experienceId.value
          : this.experienceId,
      notes: data.notes.present ? data.notes.value : this.notes,
      stomachFullness: data.stomachFullness.present
          ? data.stomachFullness.value
          : this.stomachFullness,
      consumerName: data.consumerName.present
          ? data.consumerName.value
          : this.consumerName,
      customUnitId: data.customUnitId.present
          ? data.customUnitId.value
          : this.customUnitId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ingestion(')
          ..write('id: $id, ')
          ..write('substanceName: $substanceName, ')
          ..write('time: $time, ')
          ..write('endTime: $endTime, ')
          ..write('creationDate: $creationDate, ')
          ..write('administrationRoute: $administrationRoute, ')
          ..write('dose: $dose, ')
          ..write('isDoseAnEstimate: $isDoseAnEstimate, ')
          ..write(
            'estimatedDoseStandardDeviation: $estimatedDoseStandardDeviation, ',
          )
          ..write('units: $units, ')
          ..write('experienceId: $experienceId, ')
          ..write('notes: $notes, ')
          ..write('stomachFullness: $stomachFullness, ')
          ..write('consumerName: $consumerName, ')
          ..write('customUnitId: $customUnitId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    substanceName,
    time,
    endTime,
    creationDate,
    administrationRoute,
    dose,
    isDoseAnEstimate,
    estimatedDoseStandardDeviation,
    units,
    experienceId,
    notes,
    stomachFullness,
    consumerName,
    customUnitId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingestion &&
          other.id == this.id &&
          other.substanceName == this.substanceName &&
          other.time == this.time &&
          other.endTime == this.endTime &&
          other.creationDate == this.creationDate &&
          other.administrationRoute == this.administrationRoute &&
          other.dose == this.dose &&
          other.isDoseAnEstimate == this.isDoseAnEstimate &&
          other.estimatedDoseStandardDeviation ==
              this.estimatedDoseStandardDeviation &&
          other.units == this.units &&
          other.experienceId == this.experienceId &&
          other.notes == this.notes &&
          other.stomachFullness == this.stomachFullness &&
          other.consumerName == this.consumerName &&
          other.customUnitId == this.customUnitId);
}

class IngestionsCompanion extends UpdateCompanion<Ingestion> {
  final Value<int> id;
  final Value<String> substanceName;
  final Value<DateTime> time;
  final Value<DateTime?> endTime;
  final Value<DateTime?> creationDate;
  final Value<String> administrationRoute;
  final Value<double?> dose;
  final Value<bool> isDoseAnEstimate;
  final Value<double?> estimatedDoseStandardDeviation;
  final Value<String?> units;
  final Value<int> experienceId;
  final Value<String?> notes;
  final Value<StomachFullness?> stomachFullness;
  final Value<String?> consumerName;
  final Value<int?> customUnitId;
  const IngestionsCompanion({
    this.id = const Value.absent(),
    this.substanceName = const Value.absent(),
    this.time = const Value.absent(),
    this.endTime = const Value.absent(),
    this.creationDate = const Value.absent(),
    this.administrationRoute = const Value.absent(),
    this.dose = const Value.absent(),
    this.isDoseAnEstimate = const Value.absent(),
    this.estimatedDoseStandardDeviation = const Value.absent(),
    this.units = const Value.absent(),
    this.experienceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.stomachFullness = const Value.absent(),
    this.consumerName = const Value.absent(),
    this.customUnitId = const Value.absent(),
  });
  IngestionsCompanion.insert({
    this.id = const Value.absent(),
    required String substanceName,
    required DateTime time,
    this.endTime = const Value.absent(),
    this.creationDate = const Value.absent(),
    required String administrationRoute,
    this.dose = const Value.absent(),
    required bool isDoseAnEstimate,
    this.estimatedDoseStandardDeviation = const Value.absent(),
    this.units = const Value.absent(),
    required int experienceId,
    this.notes = const Value.absent(),
    this.stomachFullness = const Value.absent(),
    this.consumerName = const Value.absent(),
    this.customUnitId = const Value.absent(),
  }) : substanceName = Value(substanceName),
       time = Value(time),
       administrationRoute = Value(administrationRoute),
       isDoseAnEstimate = Value(isDoseAnEstimate),
       experienceId = Value(experienceId);
  static Insertable<Ingestion> custom({
    Expression<int>? id,
    Expression<String>? substanceName,
    Expression<DateTime>? time,
    Expression<DateTime>? endTime,
    Expression<DateTime>? creationDate,
    Expression<String>? administrationRoute,
    Expression<double>? dose,
    Expression<bool>? isDoseAnEstimate,
    Expression<double>? estimatedDoseStandardDeviation,
    Expression<String>? units,
    Expression<int>? experienceId,
    Expression<String>? notes,
    Expression<String>? stomachFullness,
    Expression<String>? consumerName,
    Expression<int>? customUnitId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (substanceName != null) 'substance_name': substanceName,
      if (time != null) 'time': time,
      if (endTime != null) 'end_time': endTime,
      if (creationDate != null) 'creation_date': creationDate,
      if (administrationRoute != null)
        'administration_route': administrationRoute,
      if (dose != null) 'dose': dose,
      if (isDoseAnEstimate != null) 'is_dose_an_estimate': isDoseAnEstimate,
      if (estimatedDoseStandardDeviation != null)
        'estimated_dose_standard_deviation': estimatedDoseStandardDeviation,
      if (units != null) 'units': units,
      if (experienceId != null) 'experience_id': experienceId,
      if (notes != null) 'notes': notes,
      if (stomachFullness != null) 'stomach_fullness': stomachFullness,
      if (consumerName != null) 'consumer_name': consumerName,
      if (customUnitId != null) 'custom_unit_id': customUnitId,
    });
  }

  IngestionsCompanion copyWith({
    Value<int>? id,
    Value<String>? substanceName,
    Value<DateTime>? time,
    Value<DateTime?>? endTime,
    Value<DateTime?>? creationDate,
    Value<String>? administrationRoute,
    Value<double?>? dose,
    Value<bool>? isDoseAnEstimate,
    Value<double?>? estimatedDoseStandardDeviation,
    Value<String?>? units,
    Value<int>? experienceId,
    Value<String?>? notes,
    Value<StomachFullness?>? stomachFullness,
    Value<String?>? consumerName,
    Value<int?>? customUnitId,
  }) {
    return IngestionsCompanion(
      id: id ?? this.id,
      substanceName: substanceName ?? this.substanceName,
      time: time ?? this.time,
      endTime: endTime ?? this.endTime,
      creationDate: creationDate ?? this.creationDate,
      administrationRoute: administrationRoute ?? this.administrationRoute,
      dose: dose ?? this.dose,
      isDoseAnEstimate: isDoseAnEstimate ?? this.isDoseAnEstimate,
      estimatedDoseStandardDeviation:
          estimatedDoseStandardDeviation ?? this.estimatedDoseStandardDeviation,
      units: units ?? this.units,
      experienceId: experienceId ?? this.experienceId,
      notes: notes ?? this.notes,
      stomachFullness: stomachFullness ?? this.stomachFullness,
      consumerName: consumerName ?? this.consumerName,
      customUnitId: customUnitId ?? this.customUnitId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (substanceName.present) {
      map['substance_name'] = Variable<String>(substanceName.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    if (administrationRoute.present) {
      map['administration_route'] = Variable<String>(administrationRoute.value);
    }
    if (dose.present) {
      map['dose'] = Variable<double>(dose.value);
    }
    if (isDoseAnEstimate.present) {
      map['is_dose_an_estimate'] = Variable<bool>(isDoseAnEstimate.value);
    }
    if (estimatedDoseStandardDeviation.present) {
      map['estimated_dose_standard_deviation'] = Variable<double>(
        estimatedDoseStandardDeviation.value,
      );
    }
    if (units.present) {
      map['units'] = Variable<String>(units.value);
    }
    if (experienceId.present) {
      map['experience_id'] = Variable<int>(experienceId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (stomachFullness.present) {
      map['stomach_fullness'] = Variable<String>(
        $IngestionsTable.$converterstomachFullnessn.toSql(
          stomachFullness.value,
        ),
      );
    }
    if (consumerName.present) {
      map['consumer_name'] = Variable<String>(consumerName.value);
    }
    if (customUnitId.present) {
      map['custom_unit_id'] = Variable<int>(customUnitId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngestionsCompanion(')
          ..write('id: $id, ')
          ..write('substanceName: $substanceName, ')
          ..write('time: $time, ')
          ..write('endTime: $endTime, ')
          ..write('creationDate: $creationDate, ')
          ..write('administrationRoute: $administrationRoute, ')
          ..write('dose: $dose, ')
          ..write('isDoseAnEstimate: $isDoseAnEstimate, ')
          ..write(
            'estimatedDoseStandardDeviation: $estimatedDoseStandardDeviation, ',
          )
          ..write('units: $units, ')
          ..write('experienceId: $experienceId, ')
          ..write('notes: $notes, ')
          ..write('stomachFullness: $stomachFullness, ')
          ..write('consumerName: $consumerName, ')
          ..write('customUnitId: $customUnitId')
          ..write(')'))
        .toString();
  }
}

class $SubstanceCompanionsTable extends SubstanceCompanions
    with TableInfo<$SubstanceCompanionsTable, SubstanceCompanion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubstanceCompanionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _substanceNameMeta = const VerificationMeta(
    'substanceName',
  );
  @override
  late final GeneratedColumn<String> substanceName = GeneratedColumn<String>(
    'substance_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AdaptiveColor, String> color =
      GeneratedColumn<String>(
        'color',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AdaptiveColor>($SubstanceCompanionsTable.$convertercolor);
  @override
  List<GeneratedColumn> get $columns => [substanceName, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'substance_companions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubstanceCompanion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('substance_name')) {
      context.handle(
        _substanceNameMeta,
        substanceName.isAcceptableOrUnknown(
          data['substance_name']!,
          _substanceNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_substanceNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {substanceName};
  @override
  SubstanceCompanion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubstanceCompanion(
      substanceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}substance_name'],
      )!,
      color: $SubstanceCompanionsTable.$convertercolor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}color'],
        )!,
      ),
    );
  }

  @override
  $SubstanceCompanionsTable createAlias(String alias) {
    return $SubstanceCompanionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AdaptiveColor, String, String> $convertercolor =
      const EnumNameConverter<AdaptiveColor>(AdaptiveColor.values);
}

class SubstanceCompanion extends DataClass
    implements Insertable<SubstanceCompanion> {
  final String substanceName;
  final AdaptiveColor color;
  const SubstanceCompanion({required this.substanceName, required this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['substance_name'] = Variable<String>(substanceName);
    {
      map['color'] = Variable<String>(
        $SubstanceCompanionsTable.$convertercolor.toSql(color),
      );
    }
    return map;
  }

  SubstanceCompanionsCompanion toCompanion(bool nullToAbsent) {
    return SubstanceCompanionsCompanion(
      substanceName: Value(substanceName),
      color: Value(color),
    );
  }

  factory SubstanceCompanion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubstanceCompanion(
      substanceName: serializer.fromJson<String>(json['substanceName']),
      color: $SubstanceCompanionsTable.$convertercolor.fromJson(
        serializer.fromJson<String>(json['color']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'substanceName': serializer.toJson<String>(substanceName),
      'color': serializer.toJson<String>(
        $SubstanceCompanionsTable.$convertercolor.toJson(color),
      ),
    };
  }

  SubstanceCompanion copyWith({String? substanceName, AdaptiveColor? color}) =>
      SubstanceCompanion(
        substanceName: substanceName ?? this.substanceName,
        color: color ?? this.color,
      );
  SubstanceCompanion copyWithCompanion(SubstanceCompanionsCompanion data) {
    return SubstanceCompanion(
      substanceName: data.substanceName.present
          ? data.substanceName.value
          : this.substanceName,
      color: data.color.present ? data.color.value : this.color,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubstanceCompanion(')
          ..write('substanceName: $substanceName, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(substanceName, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubstanceCompanion &&
          other.substanceName == this.substanceName &&
          other.color == this.color);
}

class SubstanceCompanionsCompanion extends UpdateCompanion<SubstanceCompanion> {
  final Value<String> substanceName;
  final Value<AdaptiveColor> color;
  final Value<int> rowid;
  const SubstanceCompanionsCompanion({
    this.substanceName = const Value.absent(),
    this.color = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubstanceCompanionsCompanion.insert({
    required String substanceName,
    required AdaptiveColor color,
    this.rowid = const Value.absent(),
  }) : substanceName = Value(substanceName),
       color = Value(color);
  static Insertable<SubstanceCompanion> custom({
    Expression<String>? substanceName,
    Expression<String>? color,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (substanceName != null) 'substance_name': substanceName,
      if (color != null) 'color': color,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubstanceCompanionsCompanion copyWith({
    Value<String>? substanceName,
    Value<AdaptiveColor>? color,
    Value<int>? rowid,
  }) {
    return SubstanceCompanionsCompanion(
      substanceName: substanceName ?? this.substanceName,
      color: color ?? this.color,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (substanceName.present) {
      map['substance_name'] = Variable<String>(substanceName.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(
        $SubstanceCompanionsTable.$convertercolor.toSql(color.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubstanceCompanionsCompanion(')
          ..write('substanceName: $substanceName, ')
          ..write('color: $color, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomSubstancesTable extends CustomSubstances
    with TableInfo<$CustomSubstancesTable, CustomSubstance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomSubstancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitsMeta = const VerificationMeta('units');
  @override
  late final GeneratedColumn<String> units = GeneratedColumn<String>(
    'units',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, units, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_substances';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomSubstance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('units')) {
      context.handle(
        _unitsMeta,
        units.isAcceptableOrUnknown(data['units']!, _unitsMeta),
      );
    } else if (isInserting) {
      context.missing(_unitsMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomSubstance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomSubstance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      units: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}units'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $CustomSubstancesTable createAlias(String alias) {
    return $CustomSubstancesTable(attachedDatabase, alias);
  }
}

class CustomSubstance extends DataClass implements Insertable<CustomSubstance> {
  final int id;
  final String name;
  final String units;
  final String description;
  const CustomSubstance({
    required this.id,
    required this.name,
    required this.units,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['units'] = Variable<String>(units);
    map['description'] = Variable<String>(description);
    return map;
  }

  CustomSubstancesCompanion toCompanion(bool nullToAbsent) {
    return CustomSubstancesCompanion(
      id: Value(id),
      name: Value(name),
      units: Value(units),
      description: Value(description),
    );
  }

  factory CustomSubstance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomSubstance(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      units: serializer.fromJson<String>(json['units']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'units': serializer.toJson<String>(units),
      'description': serializer.toJson<String>(description),
    };
  }

  CustomSubstance copyWith({
    int? id,
    String? name,
    String? units,
    String? description,
  }) => CustomSubstance(
    id: id ?? this.id,
    name: name ?? this.name,
    units: units ?? this.units,
    description: description ?? this.description,
  );
  CustomSubstance copyWithCompanion(CustomSubstancesCompanion data) {
    return CustomSubstance(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      units: data.units.present ? data.units.value : this.units,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomSubstance(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('units: $units, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, units, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomSubstance &&
          other.id == this.id &&
          other.name == this.name &&
          other.units == this.units &&
          other.description == this.description);
}

class CustomSubstancesCompanion extends UpdateCompanion<CustomSubstance> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> units;
  final Value<String> description;
  const CustomSubstancesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.units = const Value.absent(),
    this.description = const Value.absent(),
  });
  CustomSubstancesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String units,
    required String description,
  }) : name = Value(name),
       units = Value(units),
       description = Value(description);
  static Insertable<CustomSubstance> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? units,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (units != null) 'units': units,
      if (description != null) 'description': description,
    });
  }

  CustomSubstancesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? units,
    Value<String>? description,
  }) {
    return CustomSubstancesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      units: units ?? this.units,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (units.present) {
      map['units'] = Variable<String>(units.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomSubstancesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('units: $units, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $ShulginRatingsTable extends ShulginRatings
    with TableInfo<$ShulginRatingsTable, ShulginRating> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShulginRatingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creationDateMeta = const VerificationMeta(
    'creationDate',
  );
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
    'creation_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ShulginRatingOption, String>
  option = GeneratedColumn<String>(
    'option',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ShulginRatingOption>($ShulginRatingsTable.$converteroption);
  static const VerificationMeta _experienceIdMeta = const VerificationMeta(
    'experienceId',
  );
  @override
  late final GeneratedColumn<int> experienceId = GeneratedColumn<int>(
    'experience_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES experiences (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    time,
    creationDate,
    option,
    experienceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shulgin_ratings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShulginRating> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    }
    if (data.containsKey('creation_date')) {
      context.handle(
        _creationDateMeta,
        creationDate.isAcceptableOrUnknown(
          data['creation_date']!,
          _creationDateMeta,
        ),
      );
    }
    if (data.containsKey('experience_id')) {
      context.handle(
        _experienceIdMeta,
        experienceId.isAcceptableOrUnknown(
          data['experience_id']!,
          _experienceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_experienceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShulginRating map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShulginRating(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      ),
      creationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_date'],
      ),
      option: $ShulginRatingsTable.$converteroption.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}option'],
        )!,
      ),
      experienceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}experience_id'],
      )!,
    );
  }

  @override
  $ShulginRatingsTable createAlias(String alias) {
    return $ShulginRatingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ShulginRatingOption, String, String>
  $converteroption = const EnumNameConverter<ShulginRatingOption>(
    ShulginRatingOption.values,
  );
}

class ShulginRating extends DataClass implements Insertable<ShulginRating> {
  final int id;
  final DateTime? time;
  final DateTime? creationDate;
  final ShulginRatingOption option;
  final int experienceId;
  const ShulginRating({
    required this.id,
    this.time,
    this.creationDate,
    required this.option,
    required this.experienceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<DateTime>(time);
    }
    if (!nullToAbsent || creationDate != null) {
      map['creation_date'] = Variable<DateTime>(creationDate);
    }
    {
      map['option'] = Variable<String>(
        $ShulginRatingsTable.$converteroption.toSql(option),
      );
    }
    map['experience_id'] = Variable<int>(experienceId);
    return map;
  }

  ShulginRatingsCompanion toCompanion(bool nullToAbsent) {
    return ShulginRatingsCompanion(
      id: Value(id),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      creationDate: creationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(creationDate),
      option: Value(option),
      experienceId: Value(experienceId),
    );
  }

  factory ShulginRating.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShulginRating(
      id: serializer.fromJson<int>(json['id']),
      time: serializer.fromJson<DateTime?>(json['time']),
      creationDate: serializer.fromJson<DateTime?>(json['creationDate']),
      option: $ShulginRatingsTable.$converteroption.fromJson(
        serializer.fromJson<String>(json['option']),
      ),
      experienceId: serializer.fromJson<int>(json['experienceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'time': serializer.toJson<DateTime?>(time),
      'creationDate': serializer.toJson<DateTime?>(creationDate),
      'option': serializer.toJson<String>(
        $ShulginRatingsTable.$converteroption.toJson(option),
      ),
      'experienceId': serializer.toJson<int>(experienceId),
    };
  }

  ShulginRating copyWith({
    int? id,
    Value<DateTime?> time = const Value.absent(),
    Value<DateTime?> creationDate = const Value.absent(),
    ShulginRatingOption? option,
    int? experienceId,
  }) => ShulginRating(
    id: id ?? this.id,
    time: time.present ? time.value : this.time,
    creationDate: creationDate.present ? creationDate.value : this.creationDate,
    option: option ?? this.option,
    experienceId: experienceId ?? this.experienceId,
  );
  ShulginRating copyWithCompanion(ShulginRatingsCompanion data) {
    return ShulginRating(
      id: data.id.present ? data.id.value : this.id,
      time: data.time.present ? data.time.value : this.time,
      creationDate: data.creationDate.present
          ? data.creationDate.value
          : this.creationDate,
      option: data.option.present ? data.option.value : this.option,
      experienceId: data.experienceId.present
          ? data.experienceId.value
          : this.experienceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShulginRating(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('creationDate: $creationDate, ')
          ..write('option: $option, ')
          ..write('experienceId: $experienceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, time, creationDate, option, experienceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShulginRating &&
          other.id == this.id &&
          other.time == this.time &&
          other.creationDate == this.creationDate &&
          other.option == this.option &&
          other.experienceId == this.experienceId);
}

class ShulginRatingsCompanion extends UpdateCompanion<ShulginRating> {
  final Value<int> id;
  final Value<DateTime?> time;
  final Value<DateTime?> creationDate;
  final Value<ShulginRatingOption> option;
  final Value<int> experienceId;
  const ShulginRatingsCompanion({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    this.creationDate = const Value.absent(),
    this.option = const Value.absent(),
    this.experienceId = const Value.absent(),
  });
  ShulginRatingsCompanion.insert({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    this.creationDate = const Value.absent(),
    required ShulginRatingOption option,
    required int experienceId,
  }) : option = Value(option),
       experienceId = Value(experienceId);
  static Insertable<ShulginRating> custom({
    Expression<int>? id,
    Expression<DateTime>? time,
    Expression<DateTime>? creationDate,
    Expression<String>? option,
    Expression<int>? experienceId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (time != null) 'time': time,
      if (creationDate != null) 'creation_date': creationDate,
      if (option != null) 'option': option,
      if (experienceId != null) 'experience_id': experienceId,
    });
  }

  ShulginRatingsCompanion copyWith({
    Value<int>? id,
    Value<DateTime?>? time,
    Value<DateTime?>? creationDate,
    Value<ShulginRatingOption>? option,
    Value<int>? experienceId,
  }) {
    return ShulginRatingsCompanion(
      id: id ?? this.id,
      time: time ?? this.time,
      creationDate: creationDate ?? this.creationDate,
      option: option ?? this.option,
      experienceId: experienceId ?? this.experienceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    if (option.present) {
      map['option'] = Variable<String>(
        $ShulginRatingsTable.$converteroption.toSql(option.value),
      );
    }
    if (experienceId.present) {
      map['experience_id'] = Variable<int>(experienceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShulginRatingsCompanion(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('creationDate: $creationDate, ')
          ..write('option: $option, ')
          ..write('experienceId: $experienceId')
          ..write(')'))
        .toString();
  }
}

class $TimedNotesTable extends TimedNotes
    with TableInfo<$TimedNotesTable, TimedNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimedNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _creationDateMeta = const VerificationMeta(
    'creationDate',
  );
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
    'creation_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AdaptiveColor, String> color =
      GeneratedColumn<String>(
        'color',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AdaptiveColor>($TimedNotesTable.$convertercolor);
  static const VerificationMeta _experienceIdMeta = const VerificationMeta(
    'experienceId',
  );
  @override
  late final GeneratedColumn<int> experienceId = GeneratedColumn<int>(
    'experience_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES experiences (id)',
    ),
  );
  static const VerificationMeta _isPartOfTimelineMeta = const VerificationMeta(
    'isPartOfTimeline',
  );
  @override
  late final GeneratedColumn<bool> isPartOfTimeline = GeneratedColumn<bool>(
    'is_part_of_timeline',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_part_of_timeline" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    creationDate,
    time,
    note,
    color,
    experienceId,
    isPartOfTimeline,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timed_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimedNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('creation_date')) {
      context.handle(
        _creationDateMeta,
        creationDate.isAcceptableOrUnknown(
          data['creation_date']!,
          _creationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('experience_id')) {
      context.handle(
        _experienceIdMeta,
        experienceId.isAcceptableOrUnknown(
          data['experience_id']!,
          _experienceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_experienceIdMeta);
    }
    if (data.containsKey('is_part_of_timeline')) {
      context.handle(
        _isPartOfTimelineMeta,
        isPartOfTimeline.isAcceptableOrUnknown(
          data['is_part_of_timeline']!,
          _isPartOfTimelineMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isPartOfTimelineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimedNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimedNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      creationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_date'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      color: $TimedNotesTable.$convertercolor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}color'],
        )!,
      ),
      experienceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}experience_id'],
      )!,
      isPartOfTimeline: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_part_of_timeline'],
      )!,
    );
  }

  @override
  $TimedNotesTable createAlias(String alias) {
    return $TimedNotesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AdaptiveColor, String, String> $convertercolor =
      const EnumNameConverter<AdaptiveColor>(AdaptiveColor.values);
}

class TimedNote extends DataClass implements Insertable<TimedNote> {
  final int id;
  final DateTime creationDate;
  final DateTime time;
  final String note;
  final AdaptiveColor color;
  final int experienceId;
  final bool isPartOfTimeline;
  const TimedNote({
    required this.id,
    required this.creationDate,
    required this.time,
    required this.note,
    required this.color,
    required this.experienceId,
    required this.isPartOfTimeline,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['creation_date'] = Variable<DateTime>(creationDate);
    map['time'] = Variable<DateTime>(time);
    map['note'] = Variable<String>(note);
    {
      map['color'] = Variable<String>(
        $TimedNotesTable.$convertercolor.toSql(color),
      );
    }
    map['experience_id'] = Variable<int>(experienceId);
    map['is_part_of_timeline'] = Variable<bool>(isPartOfTimeline);
    return map;
  }

  TimedNotesCompanion toCompanion(bool nullToAbsent) {
    return TimedNotesCompanion(
      id: Value(id),
      creationDate: Value(creationDate),
      time: Value(time),
      note: Value(note),
      color: Value(color),
      experienceId: Value(experienceId),
      isPartOfTimeline: Value(isPartOfTimeline),
    );
  }

  factory TimedNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimedNote(
      id: serializer.fromJson<int>(json['id']),
      creationDate: serializer.fromJson<DateTime>(json['creationDate']),
      time: serializer.fromJson<DateTime>(json['time']),
      note: serializer.fromJson<String>(json['note']),
      color: $TimedNotesTable.$convertercolor.fromJson(
        serializer.fromJson<String>(json['color']),
      ),
      experienceId: serializer.fromJson<int>(json['experienceId']),
      isPartOfTimeline: serializer.fromJson<bool>(json['isPartOfTimeline']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'creationDate': serializer.toJson<DateTime>(creationDate),
      'time': serializer.toJson<DateTime>(time),
      'note': serializer.toJson<String>(note),
      'color': serializer.toJson<String>(
        $TimedNotesTable.$convertercolor.toJson(color),
      ),
      'experienceId': serializer.toJson<int>(experienceId),
      'isPartOfTimeline': serializer.toJson<bool>(isPartOfTimeline),
    };
  }

  TimedNote copyWith({
    int? id,
    DateTime? creationDate,
    DateTime? time,
    String? note,
    AdaptiveColor? color,
    int? experienceId,
    bool? isPartOfTimeline,
  }) => TimedNote(
    id: id ?? this.id,
    creationDate: creationDate ?? this.creationDate,
    time: time ?? this.time,
    note: note ?? this.note,
    color: color ?? this.color,
    experienceId: experienceId ?? this.experienceId,
    isPartOfTimeline: isPartOfTimeline ?? this.isPartOfTimeline,
  );
  TimedNote copyWithCompanion(TimedNotesCompanion data) {
    return TimedNote(
      id: data.id.present ? data.id.value : this.id,
      creationDate: data.creationDate.present
          ? data.creationDate.value
          : this.creationDate,
      time: data.time.present ? data.time.value : this.time,
      note: data.note.present ? data.note.value : this.note,
      color: data.color.present ? data.color.value : this.color,
      experienceId: data.experienceId.present
          ? data.experienceId.value
          : this.experienceId,
      isPartOfTimeline: data.isPartOfTimeline.present
          ? data.isPartOfTimeline.value
          : this.isPartOfTimeline,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimedNote(')
          ..write('id: $id, ')
          ..write('creationDate: $creationDate, ')
          ..write('time: $time, ')
          ..write('note: $note, ')
          ..write('color: $color, ')
          ..write('experienceId: $experienceId, ')
          ..write('isPartOfTimeline: $isPartOfTimeline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    creationDate,
    time,
    note,
    color,
    experienceId,
    isPartOfTimeline,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimedNote &&
          other.id == this.id &&
          other.creationDate == this.creationDate &&
          other.time == this.time &&
          other.note == this.note &&
          other.color == this.color &&
          other.experienceId == this.experienceId &&
          other.isPartOfTimeline == this.isPartOfTimeline);
}

class TimedNotesCompanion extends UpdateCompanion<TimedNote> {
  final Value<int> id;
  final Value<DateTime> creationDate;
  final Value<DateTime> time;
  final Value<String> note;
  final Value<AdaptiveColor> color;
  final Value<int> experienceId;
  final Value<bool> isPartOfTimeline;
  const TimedNotesCompanion({
    this.id = const Value.absent(),
    this.creationDate = const Value.absent(),
    this.time = const Value.absent(),
    this.note = const Value.absent(),
    this.color = const Value.absent(),
    this.experienceId = const Value.absent(),
    this.isPartOfTimeline = const Value.absent(),
  });
  TimedNotesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime creationDate,
    required DateTime time,
    required String note,
    required AdaptiveColor color,
    required int experienceId,
    required bool isPartOfTimeline,
  }) : creationDate = Value(creationDate),
       time = Value(time),
       note = Value(note),
       color = Value(color),
       experienceId = Value(experienceId),
       isPartOfTimeline = Value(isPartOfTimeline);
  static Insertable<TimedNote> custom({
    Expression<int>? id,
    Expression<DateTime>? creationDate,
    Expression<DateTime>? time,
    Expression<String>? note,
    Expression<String>? color,
    Expression<int>? experienceId,
    Expression<bool>? isPartOfTimeline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creationDate != null) 'creation_date': creationDate,
      if (time != null) 'time': time,
      if (note != null) 'note': note,
      if (color != null) 'color': color,
      if (experienceId != null) 'experience_id': experienceId,
      if (isPartOfTimeline != null) 'is_part_of_timeline': isPartOfTimeline,
    });
  }

  TimedNotesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? creationDate,
    Value<DateTime>? time,
    Value<String>? note,
    Value<AdaptiveColor>? color,
    Value<int>? experienceId,
    Value<bool>? isPartOfTimeline,
  }) {
    return TimedNotesCompanion(
      id: id ?? this.id,
      creationDate: creationDate ?? this.creationDate,
      time: time ?? this.time,
      note: note ?? this.note,
      color: color ?? this.color,
      experienceId: experienceId ?? this.experienceId,
      isPartOfTimeline: isPartOfTimeline ?? this.isPartOfTimeline,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(
        $TimedNotesTable.$convertercolor.toSql(color.value),
      );
    }
    if (experienceId.present) {
      map['experience_id'] = Variable<int>(experienceId.value);
    }
    if (isPartOfTimeline.present) {
      map['is_part_of_timeline'] = Variable<bool>(isPartOfTimeline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimedNotesCompanion(')
          ..write('id: $id, ')
          ..write('creationDate: $creationDate, ')
          ..write('time: $time, ')
          ..write('note: $note, ')
          ..write('color: $color, ')
          ..write('experienceId: $experienceId, ')
          ..write('isPartOfTimeline: $isPartOfTimeline')
          ..write(')'))
        .toString();
  }
}

class $CustomUnitsTable extends CustomUnits
    with TableInfo<$CustomUnitsTable, CustomUnit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomUnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _substanceNameMeta = const VerificationMeta(
    'substanceName',
  );
  @override
  late final GeneratedColumn<String> substanceName = GeneratedColumn<String>(
    'substance_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationDateMeta = const VerificationMeta(
    'creationDate',
  );
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
    'creation_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _administrationRouteMeta =
      const VerificationMeta('administrationRoute');
  @override
  late final GeneratedColumn<String> administrationRoute =
      GeneratedColumn<String>(
        'administration_route',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _doseMeta = const VerificationMeta('dose');
  @override
  late final GeneratedColumn<double> dose = GeneratedColumn<double>(
    'dose',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedDoseStandardDeviationMeta =
      const VerificationMeta('estimatedDoseStandardDeviation');
  @override
  late final GeneratedColumn<double> estimatedDoseStandardDeviation =
      GeneratedColumn<double>(
        'estimated_dose_standard_deviation',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isEstimateMeta = const VerificationMeta(
    'isEstimate',
  );
  @override
  late final GeneratedColumn<bool> isEstimate = GeneratedColumn<bool>(
    'is_estimate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_estimate" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPluralMeta = const VerificationMeta(
    'unitPlural',
  );
  @override
  late final GeneratedColumn<String> unitPlural = GeneratedColumn<String>(
    'unit_plural',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalUnitMeta = const VerificationMeta(
    'originalUnit',
  );
  @override
  late final GeneratedColumn<String> originalUnit = GeneratedColumn<String>(
    'original_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    substanceName,
    name,
    creationDate,
    administrationRoute,
    dose,
    estimatedDoseStandardDeviation,
    isEstimate,
    isArchived,
    unit,
    unitPlural,
    originalUnit,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_units';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomUnit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('substance_name')) {
      context.handle(
        _substanceNameMeta,
        substanceName.isAcceptableOrUnknown(
          data['substance_name']!,
          _substanceNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_substanceNameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('creation_date')) {
      context.handle(
        _creationDateMeta,
        creationDate.isAcceptableOrUnknown(
          data['creation_date']!,
          _creationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    if (data.containsKey('administration_route')) {
      context.handle(
        _administrationRouteMeta,
        administrationRoute.isAcceptableOrUnknown(
          data['administration_route']!,
          _administrationRouteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_administrationRouteMeta);
    }
    if (data.containsKey('dose')) {
      context.handle(
        _doseMeta,
        dose.isAcceptableOrUnknown(data['dose']!, _doseMeta),
      );
    }
    if (data.containsKey('estimated_dose_standard_deviation')) {
      context.handle(
        _estimatedDoseStandardDeviationMeta,
        estimatedDoseStandardDeviation.isAcceptableOrUnknown(
          data['estimated_dose_standard_deviation']!,
          _estimatedDoseStandardDeviationMeta,
        ),
      );
    }
    if (data.containsKey('is_estimate')) {
      context.handle(
        _isEstimateMeta,
        isEstimate.isAcceptableOrUnknown(data['is_estimate']!, _isEstimateMeta),
      );
    } else if (isInserting) {
      context.missing(_isEstimateMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    } else if (isInserting) {
      context.missing(_isArchivedMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('unit_plural')) {
      context.handle(
        _unitPluralMeta,
        unitPlural.isAcceptableOrUnknown(data['unit_plural']!, _unitPluralMeta),
      );
    }
    if (data.containsKey('original_unit')) {
      context.handle(
        _originalUnitMeta,
        originalUnit.isAcceptableOrUnknown(
          data['original_unit']!,
          _originalUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalUnitMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomUnit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomUnit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      substanceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}substance_name'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      creationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_date'],
      )!,
      administrationRoute: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}administration_route'],
      )!,
      dose: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dose'],
      ),
      estimatedDoseStandardDeviation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_dose_standard_deviation'],
      ),
      isEstimate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_estimate'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      unitPlural: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_plural'],
      ),
      originalUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_unit'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  $CustomUnitsTable createAlias(String alias) {
    return $CustomUnitsTable(attachedDatabase, alias);
  }
}

class CustomUnit extends DataClass implements Insertable<CustomUnit> {
  final int id;
  final String substanceName;
  final String name;
  final DateTime creationDate;
  final String administrationRoute;
  final double? dose;
  final double? estimatedDoseStandardDeviation;
  final bool isEstimate;
  final bool isArchived;
  final String unit;
  final String? unitPlural;
  final String originalUnit;
  final String note;
  const CustomUnit({
    required this.id,
    required this.substanceName,
    required this.name,
    required this.creationDate,
    required this.administrationRoute,
    this.dose,
    this.estimatedDoseStandardDeviation,
    required this.isEstimate,
    required this.isArchived,
    required this.unit,
    this.unitPlural,
    required this.originalUnit,
    required this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['substance_name'] = Variable<String>(substanceName);
    map['name'] = Variable<String>(name);
    map['creation_date'] = Variable<DateTime>(creationDate);
    map['administration_route'] = Variable<String>(administrationRoute);
    if (!nullToAbsent || dose != null) {
      map['dose'] = Variable<double>(dose);
    }
    if (!nullToAbsent || estimatedDoseStandardDeviation != null) {
      map['estimated_dose_standard_deviation'] = Variable<double>(
        estimatedDoseStandardDeviation,
      );
    }
    map['is_estimate'] = Variable<bool>(isEstimate);
    map['is_archived'] = Variable<bool>(isArchived);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || unitPlural != null) {
      map['unit_plural'] = Variable<String>(unitPlural);
    }
    map['original_unit'] = Variable<String>(originalUnit);
    map['note'] = Variable<String>(note);
    return map;
  }

  CustomUnitsCompanion toCompanion(bool nullToAbsent) {
    return CustomUnitsCompanion(
      id: Value(id),
      substanceName: Value(substanceName),
      name: Value(name),
      creationDate: Value(creationDate),
      administrationRoute: Value(administrationRoute),
      dose: dose == null && nullToAbsent ? const Value.absent() : Value(dose),
      estimatedDoseStandardDeviation:
          estimatedDoseStandardDeviation == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedDoseStandardDeviation),
      isEstimate: Value(isEstimate),
      isArchived: Value(isArchived),
      unit: Value(unit),
      unitPlural: unitPlural == null && nullToAbsent
          ? const Value.absent()
          : Value(unitPlural),
      originalUnit: Value(originalUnit),
      note: Value(note),
    );
  }

  factory CustomUnit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomUnit(
      id: serializer.fromJson<int>(json['id']),
      substanceName: serializer.fromJson<String>(json['substanceName']),
      name: serializer.fromJson<String>(json['name']),
      creationDate: serializer.fromJson<DateTime>(json['creationDate']),
      administrationRoute: serializer.fromJson<String>(
        json['administrationRoute'],
      ),
      dose: serializer.fromJson<double?>(json['dose']),
      estimatedDoseStandardDeviation: serializer.fromJson<double?>(
        json['estimatedDoseStandardDeviation'],
      ),
      isEstimate: serializer.fromJson<bool>(json['isEstimate']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      unit: serializer.fromJson<String>(json['unit']),
      unitPlural: serializer.fromJson<String?>(json['unitPlural']),
      originalUnit: serializer.fromJson<String>(json['originalUnit']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'substanceName': serializer.toJson<String>(substanceName),
      'name': serializer.toJson<String>(name),
      'creationDate': serializer.toJson<DateTime>(creationDate),
      'administrationRoute': serializer.toJson<String>(administrationRoute),
      'dose': serializer.toJson<double?>(dose),
      'estimatedDoseStandardDeviation': serializer.toJson<double?>(
        estimatedDoseStandardDeviation,
      ),
      'isEstimate': serializer.toJson<bool>(isEstimate),
      'isArchived': serializer.toJson<bool>(isArchived),
      'unit': serializer.toJson<String>(unit),
      'unitPlural': serializer.toJson<String?>(unitPlural),
      'originalUnit': serializer.toJson<String>(originalUnit),
      'note': serializer.toJson<String>(note),
    };
  }

  CustomUnit copyWith({
    int? id,
    String? substanceName,
    String? name,
    DateTime? creationDate,
    String? administrationRoute,
    Value<double?> dose = const Value.absent(),
    Value<double?> estimatedDoseStandardDeviation = const Value.absent(),
    bool? isEstimate,
    bool? isArchived,
    String? unit,
    Value<String?> unitPlural = const Value.absent(),
    String? originalUnit,
    String? note,
  }) => CustomUnit(
    id: id ?? this.id,
    substanceName: substanceName ?? this.substanceName,
    name: name ?? this.name,
    creationDate: creationDate ?? this.creationDate,
    administrationRoute: administrationRoute ?? this.administrationRoute,
    dose: dose.present ? dose.value : this.dose,
    estimatedDoseStandardDeviation: estimatedDoseStandardDeviation.present
        ? estimatedDoseStandardDeviation.value
        : this.estimatedDoseStandardDeviation,
    isEstimate: isEstimate ?? this.isEstimate,
    isArchived: isArchived ?? this.isArchived,
    unit: unit ?? this.unit,
    unitPlural: unitPlural.present ? unitPlural.value : this.unitPlural,
    originalUnit: originalUnit ?? this.originalUnit,
    note: note ?? this.note,
  );
  CustomUnit copyWithCompanion(CustomUnitsCompanion data) {
    return CustomUnit(
      id: data.id.present ? data.id.value : this.id,
      substanceName: data.substanceName.present
          ? data.substanceName.value
          : this.substanceName,
      name: data.name.present ? data.name.value : this.name,
      creationDate: data.creationDate.present
          ? data.creationDate.value
          : this.creationDate,
      administrationRoute: data.administrationRoute.present
          ? data.administrationRoute.value
          : this.administrationRoute,
      dose: data.dose.present ? data.dose.value : this.dose,
      estimatedDoseStandardDeviation:
          data.estimatedDoseStandardDeviation.present
          ? data.estimatedDoseStandardDeviation.value
          : this.estimatedDoseStandardDeviation,
      isEstimate: data.isEstimate.present
          ? data.isEstimate.value
          : this.isEstimate,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      unit: data.unit.present ? data.unit.value : this.unit,
      unitPlural: data.unitPlural.present
          ? data.unitPlural.value
          : this.unitPlural,
      originalUnit: data.originalUnit.present
          ? data.originalUnit.value
          : this.originalUnit,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomUnit(')
          ..write('id: $id, ')
          ..write('substanceName: $substanceName, ')
          ..write('name: $name, ')
          ..write('creationDate: $creationDate, ')
          ..write('administrationRoute: $administrationRoute, ')
          ..write('dose: $dose, ')
          ..write(
            'estimatedDoseStandardDeviation: $estimatedDoseStandardDeviation, ',
          )
          ..write('isEstimate: $isEstimate, ')
          ..write('isArchived: $isArchived, ')
          ..write('unit: $unit, ')
          ..write('unitPlural: $unitPlural, ')
          ..write('originalUnit: $originalUnit, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    substanceName,
    name,
    creationDate,
    administrationRoute,
    dose,
    estimatedDoseStandardDeviation,
    isEstimate,
    isArchived,
    unit,
    unitPlural,
    originalUnit,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomUnit &&
          other.id == this.id &&
          other.substanceName == this.substanceName &&
          other.name == this.name &&
          other.creationDate == this.creationDate &&
          other.administrationRoute == this.administrationRoute &&
          other.dose == this.dose &&
          other.estimatedDoseStandardDeviation ==
              this.estimatedDoseStandardDeviation &&
          other.isEstimate == this.isEstimate &&
          other.isArchived == this.isArchived &&
          other.unit == this.unit &&
          other.unitPlural == this.unitPlural &&
          other.originalUnit == this.originalUnit &&
          other.note == this.note);
}

class CustomUnitsCompanion extends UpdateCompanion<CustomUnit> {
  final Value<int> id;
  final Value<String> substanceName;
  final Value<String> name;
  final Value<DateTime> creationDate;
  final Value<String> administrationRoute;
  final Value<double?> dose;
  final Value<double?> estimatedDoseStandardDeviation;
  final Value<bool> isEstimate;
  final Value<bool> isArchived;
  final Value<String> unit;
  final Value<String?> unitPlural;
  final Value<String> originalUnit;
  final Value<String> note;
  const CustomUnitsCompanion({
    this.id = const Value.absent(),
    this.substanceName = const Value.absent(),
    this.name = const Value.absent(),
    this.creationDate = const Value.absent(),
    this.administrationRoute = const Value.absent(),
    this.dose = const Value.absent(),
    this.estimatedDoseStandardDeviation = const Value.absent(),
    this.isEstimate = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.unit = const Value.absent(),
    this.unitPlural = const Value.absent(),
    this.originalUnit = const Value.absent(),
    this.note = const Value.absent(),
  });
  CustomUnitsCompanion.insert({
    this.id = const Value.absent(),
    required String substanceName,
    required String name,
    required DateTime creationDate,
    required String administrationRoute,
    this.dose = const Value.absent(),
    this.estimatedDoseStandardDeviation = const Value.absent(),
    required bool isEstimate,
    required bool isArchived,
    required String unit,
    this.unitPlural = const Value.absent(),
    required String originalUnit,
    required String note,
  }) : substanceName = Value(substanceName),
       name = Value(name),
       creationDate = Value(creationDate),
       administrationRoute = Value(administrationRoute),
       isEstimate = Value(isEstimate),
       isArchived = Value(isArchived),
       unit = Value(unit),
       originalUnit = Value(originalUnit),
       note = Value(note);
  static Insertable<CustomUnit> custom({
    Expression<int>? id,
    Expression<String>? substanceName,
    Expression<String>? name,
    Expression<DateTime>? creationDate,
    Expression<String>? administrationRoute,
    Expression<double>? dose,
    Expression<double>? estimatedDoseStandardDeviation,
    Expression<bool>? isEstimate,
    Expression<bool>? isArchived,
    Expression<String>? unit,
    Expression<String>? unitPlural,
    Expression<String>? originalUnit,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (substanceName != null) 'substance_name': substanceName,
      if (name != null) 'name': name,
      if (creationDate != null) 'creation_date': creationDate,
      if (administrationRoute != null)
        'administration_route': administrationRoute,
      if (dose != null) 'dose': dose,
      if (estimatedDoseStandardDeviation != null)
        'estimated_dose_standard_deviation': estimatedDoseStandardDeviation,
      if (isEstimate != null) 'is_estimate': isEstimate,
      if (isArchived != null) 'is_archived': isArchived,
      if (unit != null) 'unit': unit,
      if (unitPlural != null) 'unit_plural': unitPlural,
      if (originalUnit != null) 'original_unit': originalUnit,
      if (note != null) 'note': note,
    });
  }

  CustomUnitsCompanion copyWith({
    Value<int>? id,
    Value<String>? substanceName,
    Value<String>? name,
    Value<DateTime>? creationDate,
    Value<String>? administrationRoute,
    Value<double?>? dose,
    Value<double?>? estimatedDoseStandardDeviation,
    Value<bool>? isEstimate,
    Value<bool>? isArchived,
    Value<String>? unit,
    Value<String?>? unitPlural,
    Value<String>? originalUnit,
    Value<String>? note,
  }) {
    return CustomUnitsCompanion(
      id: id ?? this.id,
      substanceName: substanceName ?? this.substanceName,
      name: name ?? this.name,
      creationDate: creationDate ?? this.creationDate,
      administrationRoute: administrationRoute ?? this.administrationRoute,
      dose: dose ?? this.dose,
      estimatedDoseStandardDeviation:
          estimatedDoseStandardDeviation ?? this.estimatedDoseStandardDeviation,
      isEstimate: isEstimate ?? this.isEstimate,
      isArchived: isArchived ?? this.isArchived,
      unit: unit ?? this.unit,
      unitPlural: unitPlural ?? this.unitPlural,
      originalUnit: originalUnit ?? this.originalUnit,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (substanceName.present) {
      map['substance_name'] = Variable<String>(substanceName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    if (administrationRoute.present) {
      map['administration_route'] = Variable<String>(administrationRoute.value);
    }
    if (dose.present) {
      map['dose'] = Variable<double>(dose.value);
    }
    if (estimatedDoseStandardDeviation.present) {
      map['estimated_dose_standard_deviation'] = Variable<double>(
        estimatedDoseStandardDeviation.value,
      );
    }
    if (isEstimate.present) {
      map['is_estimate'] = Variable<bool>(isEstimate.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (unitPlural.present) {
      map['unit_plural'] = Variable<String>(unitPlural.value);
    }
    if (originalUnit.present) {
      map['original_unit'] = Variable<String>(originalUnit.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomUnitsCompanion(')
          ..write('id: $id, ')
          ..write('substanceName: $substanceName, ')
          ..write('name: $name, ')
          ..write('creationDate: $creationDate, ')
          ..write('administrationRoute: $administrationRoute, ')
          ..write('dose: $dose, ')
          ..write(
            'estimatedDoseStandardDeviation: $estimatedDoseStandardDeviation, ',
          )
          ..write('isEstimate: $isEstimate, ')
          ..write('isArchived: $isArchived, ')
          ..write('unit: $unit, ')
          ..write('unitPlural: $unitPlural, ')
          ..write('originalUnit: $originalUnit, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExperiencesTable experiences = $ExperiencesTable(this);
  late final $IngestionsTable ingestions = $IngestionsTable(this);
  late final $SubstanceCompanionsTable substanceCompanions =
      $SubstanceCompanionsTable(this);
  late final $CustomSubstancesTable customSubstances = $CustomSubstancesTable(
    this,
  );
  late final $ShulginRatingsTable shulginRatings = $ShulginRatingsTable(this);
  late final $TimedNotesTable timedNotes = $TimedNotesTable(this);
  late final $CustomUnitsTable customUnits = $CustomUnitsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    experiences,
    ingestions,
    substanceCompanions,
    customSubstances,
    shulginRatings,
    timedNotes,
    customUnits,
  ];
}

typedef $$ExperiencesTableCreateCompanionBuilder =
    ExperiencesCompanion Function({
      Value<int> id,
      required String title,
      required String textContent,
      required DateTime creationDate,
      required DateTime sortDate,
      required bool isFavorite,
      Value<String?> locationName,
      Value<double?> longitude,
      Value<double?> latitude,
    });
typedef $$ExperiencesTableUpdateCompanionBuilder =
    ExperiencesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> textContent,
      Value<DateTime> creationDate,
      Value<DateTime> sortDate,
      Value<bool> isFavorite,
      Value<String?> locationName,
      Value<double?> longitude,
      Value<double?> latitude,
    });

final class $$ExperiencesTableReferences
    extends BaseReferences<_$AppDatabase, $ExperiencesTable, Experience> {
  $$ExperiencesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$IngestionsTable, List<Ingestion>>
  _ingestionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ingestions,
    aliasName: 'experiences__id__ingestions__experience_id',
  );

  $$IngestionsTableProcessedTableManager get ingestionsRefs {
    final manager = $$IngestionsTableTableManager(
      $_db,
      $_db.ingestions,
    ).filter((f) => f.experienceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ingestionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ShulginRatingsTable, List<ShulginRating>>
  _shulginRatingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.shulginRatings,
    aliasName: 'experiences__id__shulgin_ratings__experience_id',
  );

  $$ShulginRatingsTableProcessedTableManager get shulginRatingsRefs {
    final manager = $$ShulginRatingsTableTableManager(
      $_db,
      $_db.shulginRatings,
    ).filter((f) => f.experienceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_shulginRatingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TimedNotesTable, List<TimedNote>>
  _timedNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timedNotes,
    aliasName: 'experiences__id__timed_notes__experience_id',
  );

  $$TimedNotesTableProcessedTableManager get timedNotesRefs {
    final manager = $$TimedNotesTableTableManager(
      $_db,
      $_db.timedNotes,
    ).filter((f) => f.experienceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_timedNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExperiencesTableFilterComposer
    extends Composer<_$AppDatabase, $ExperiencesTable> {
  $$ExperiencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sortDate => $composableBuilder(
    column: $table.sortDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ingestionsRefs(
    Expression<bool> Function($$IngestionsTableFilterComposer f) f,
  ) {
    final $$IngestionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ingestions,
      getReferencedColumn: (t) => t.experienceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngestionsTableFilterComposer(
            $db: $db,
            $table: $db.ingestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shulginRatingsRefs(
    Expression<bool> Function($$ShulginRatingsTableFilterComposer f) f,
  ) {
    final $$ShulginRatingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shulginRatings,
      getReferencedColumn: (t) => t.experienceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShulginRatingsTableFilterComposer(
            $db: $db,
            $table: $db.shulginRatings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> timedNotesRefs(
    Expression<bool> Function($$TimedNotesTableFilterComposer f) f,
  ) {
    final $$TimedNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timedNotes,
      getReferencedColumn: (t) => t.experienceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimedNotesTableFilterComposer(
            $db: $db,
            $table: $db.timedNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExperiencesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExperiencesTable> {
  $$ExperiencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sortDate => $composableBuilder(
    column: $table.sortDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExperiencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExperiencesTable> {
  $$ExperiencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sortDate =>
      $composableBuilder(column: $table.sortDate, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  Expression<T> ingestionsRefs<T extends Object>(
    Expression<T> Function($$IngestionsTableAnnotationComposer a) f,
  ) {
    final $$IngestionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ingestions,
      getReferencedColumn: (t) => t.experienceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngestionsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingestions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shulginRatingsRefs<T extends Object>(
    Expression<T> Function($$ShulginRatingsTableAnnotationComposer a) f,
  ) {
    final $$ShulginRatingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shulginRatings,
      getReferencedColumn: (t) => t.experienceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShulginRatingsTableAnnotationComposer(
            $db: $db,
            $table: $db.shulginRatings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> timedNotesRefs<T extends Object>(
    Expression<T> Function($$TimedNotesTableAnnotationComposer a) f,
  ) {
    final $$TimedNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timedNotes,
      getReferencedColumn: (t) => t.experienceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimedNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.timedNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExperiencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExperiencesTable,
          Experience,
          $$ExperiencesTableFilterComposer,
          $$ExperiencesTableOrderingComposer,
          $$ExperiencesTableAnnotationComposer,
          $$ExperiencesTableCreateCompanionBuilder,
          $$ExperiencesTableUpdateCompanionBuilder,
          (Experience, $$ExperiencesTableReferences),
          Experience,
          PrefetchHooks Function({
            bool ingestionsRefs,
            bool shulginRatingsRefs,
            bool timedNotesRefs,
          })
        > {
  $$ExperiencesTableTableManager(_$AppDatabase db, $ExperiencesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExperiencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExperiencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExperiencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<DateTime> creationDate = const Value.absent(),
                Value<DateTime> sortDate = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> locationName = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
              }) => ExperiencesCompanion(
                id: id,
                title: title,
                textContent: textContent,
                creationDate: creationDate,
                sortDate: sortDate,
                isFavorite: isFavorite,
                locationName: locationName,
                longitude: longitude,
                latitude: latitude,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String textContent,
                required DateTime creationDate,
                required DateTime sortDate,
                required bool isFavorite,
                Value<String?> locationName = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
              }) => ExperiencesCompanion.insert(
                id: id,
                title: title,
                textContent: textContent,
                creationDate: creationDate,
                sortDate: sortDate,
                isFavorite: isFavorite,
                locationName: locationName,
                longitude: longitude,
                latitude: latitude,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExperiencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ingestionsRefs = false,
                shulginRatingsRefs = false,
                timedNotesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ingestionsRefs) db.ingestions,
                    if (shulginRatingsRefs) db.shulginRatings,
                    if (timedNotesRefs) db.timedNotes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ingestionsRefs)
                        await $_getPrefetchedData<
                          Experience,
                          $ExperiencesTable,
                          Ingestion
                        >(
                          currentTable: table,
                          referencedTable: $$ExperiencesTableReferences
                              ._ingestionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExperiencesTableReferences(
                                db,
                                table,
                                p0,
                              ).ingestionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.experienceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (shulginRatingsRefs)
                        await $_getPrefetchedData<
                          Experience,
                          $ExperiencesTable,
                          ShulginRating
                        >(
                          currentTable: table,
                          referencedTable: $$ExperiencesTableReferences
                              ._shulginRatingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExperiencesTableReferences(
                                db,
                                table,
                                p0,
                              ).shulginRatingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.experienceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (timedNotesRefs)
                        await $_getPrefetchedData<
                          Experience,
                          $ExperiencesTable,
                          TimedNote
                        >(
                          currentTable: table,
                          referencedTable: $$ExperiencesTableReferences
                              ._timedNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExperiencesTableReferences(
                                db,
                                table,
                                p0,
                              ).timedNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.experienceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExperiencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExperiencesTable,
      Experience,
      $$ExperiencesTableFilterComposer,
      $$ExperiencesTableOrderingComposer,
      $$ExperiencesTableAnnotationComposer,
      $$ExperiencesTableCreateCompanionBuilder,
      $$ExperiencesTableUpdateCompanionBuilder,
      (Experience, $$ExperiencesTableReferences),
      Experience,
      PrefetchHooks Function({
        bool ingestionsRefs,
        bool shulginRatingsRefs,
        bool timedNotesRefs,
      })
    >;
typedef $$IngestionsTableCreateCompanionBuilder =
    IngestionsCompanion Function({
      Value<int> id,
      required String substanceName,
      required DateTime time,
      Value<DateTime?> endTime,
      Value<DateTime?> creationDate,
      required String administrationRoute,
      Value<double?> dose,
      required bool isDoseAnEstimate,
      Value<double?> estimatedDoseStandardDeviation,
      Value<String?> units,
      required int experienceId,
      Value<String?> notes,
      Value<StomachFullness?> stomachFullness,
      Value<String?> consumerName,
      Value<int?> customUnitId,
    });
typedef $$IngestionsTableUpdateCompanionBuilder =
    IngestionsCompanion Function({
      Value<int> id,
      Value<String> substanceName,
      Value<DateTime> time,
      Value<DateTime?> endTime,
      Value<DateTime?> creationDate,
      Value<String> administrationRoute,
      Value<double?> dose,
      Value<bool> isDoseAnEstimate,
      Value<double?> estimatedDoseStandardDeviation,
      Value<String?> units,
      Value<int> experienceId,
      Value<String?> notes,
      Value<StomachFullness?> stomachFullness,
      Value<String?> consumerName,
      Value<int?> customUnitId,
    });

final class $$IngestionsTableReferences
    extends BaseReferences<_$AppDatabase, $IngestionsTable, Ingestion> {
  $$IngestionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExperiencesTable _experienceIdTable(_$AppDatabase db) =>
      db.experiences.createAlias('ingestions__experience_id__experiences__id');

  $$ExperiencesTableProcessedTableManager get experienceId {
    final $_column = $_itemColumn<int>('experience_id')!;

    final manager = $$ExperiencesTableTableManager(
      $_db,
      $_db.experiences,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_experienceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IngestionsTableFilterComposer
    extends Composer<_$AppDatabase, $IngestionsTable> {
  $$IngestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get substanceName => $composableBuilder(
    column: $table.substanceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get administrationRoute => $composableBuilder(
    column: $table.administrationRoute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDoseAnEstimate => $composableBuilder(
    column: $table.isDoseAnEstimate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedDoseStandardDeviation =>
      $composableBuilder(
        column: $table.estimatedDoseStandardDeviation,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get units => $composableBuilder(
    column: $table.units,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StomachFullness?, StomachFullness, String>
  get stomachFullness => $composableBuilder(
    column: $table.stomachFullness,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get consumerName => $composableBuilder(
    column: $table.consumerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customUnitId => $composableBuilder(
    column: $table.customUnitId,
    builder: (column) => ColumnFilters(column),
  );

  $$ExperiencesTableFilterComposer get experienceId {
    final $$ExperiencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.experienceId,
      referencedTable: $db.experiences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExperiencesTableFilterComposer(
            $db: $db,
            $table: $db.experiences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $IngestionsTable> {
  $$IngestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get substanceName => $composableBuilder(
    column: $table.substanceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get administrationRoute => $composableBuilder(
    column: $table.administrationRoute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDoseAnEstimate => $composableBuilder(
    column: $table.isDoseAnEstimate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedDoseStandardDeviation =>
      $composableBuilder(
        column: $table.estimatedDoseStandardDeviation,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get units => $composableBuilder(
    column: $table.units,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stomachFullness => $composableBuilder(
    column: $table.stomachFullness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get consumerName => $composableBuilder(
    column: $table.consumerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customUnitId => $composableBuilder(
    column: $table.customUnitId,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExperiencesTableOrderingComposer get experienceId {
    final $$ExperiencesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.experienceId,
      referencedTable: $db.experiences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExperiencesTableOrderingComposer(
            $db: $db,
            $table: $db.experiences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngestionsTable> {
  $$IngestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get substanceName => $composableBuilder(
    column: $table.substanceName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get administrationRoute => $composableBuilder(
    column: $table.administrationRoute,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dose =>
      $composableBuilder(column: $table.dose, builder: (column) => column);

  GeneratedColumn<bool> get isDoseAnEstimate => $composableBuilder(
    column: $table.isDoseAnEstimate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedDoseStandardDeviation =>
      $composableBuilder(
        column: $table.estimatedDoseStandardDeviation,
        builder: (column) => column,
      );

  GeneratedColumn<String> get units =>
      $composableBuilder(column: $table.units, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StomachFullness?, String>
  get stomachFullness => $composableBuilder(
    column: $table.stomachFullness,
    builder: (column) => column,
  );

  GeneratedColumn<String> get consumerName => $composableBuilder(
    column: $table.consumerName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customUnitId => $composableBuilder(
    column: $table.customUnitId,
    builder: (column) => column,
  );

  $$ExperiencesTableAnnotationComposer get experienceId {
    final $$ExperiencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.experienceId,
      referencedTable: $db.experiences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExperiencesTableAnnotationComposer(
            $db: $db,
            $table: $db.experiences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IngestionsTable,
          Ingestion,
          $$IngestionsTableFilterComposer,
          $$IngestionsTableOrderingComposer,
          $$IngestionsTableAnnotationComposer,
          $$IngestionsTableCreateCompanionBuilder,
          $$IngestionsTableUpdateCompanionBuilder,
          (Ingestion, $$IngestionsTableReferences),
          Ingestion,
          PrefetchHooks Function({bool experienceId})
        > {
  $$IngestionsTableTableManager(_$AppDatabase db, $IngestionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> substanceName = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<DateTime?> creationDate = const Value.absent(),
                Value<String> administrationRoute = const Value.absent(),
                Value<double?> dose = const Value.absent(),
                Value<bool> isDoseAnEstimate = const Value.absent(),
                Value<double?> estimatedDoseStandardDeviation =
                    const Value.absent(),
                Value<String?> units = const Value.absent(),
                Value<int> experienceId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<StomachFullness?> stomachFullness = const Value.absent(),
                Value<String?> consumerName = const Value.absent(),
                Value<int?> customUnitId = const Value.absent(),
              }) => IngestionsCompanion(
                id: id,
                substanceName: substanceName,
                time: time,
                endTime: endTime,
                creationDate: creationDate,
                administrationRoute: administrationRoute,
                dose: dose,
                isDoseAnEstimate: isDoseAnEstimate,
                estimatedDoseStandardDeviation: estimatedDoseStandardDeviation,
                units: units,
                experienceId: experienceId,
                notes: notes,
                stomachFullness: stomachFullness,
                consumerName: consumerName,
                customUnitId: customUnitId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String substanceName,
                required DateTime time,
                Value<DateTime?> endTime = const Value.absent(),
                Value<DateTime?> creationDate = const Value.absent(),
                required String administrationRoute,
                Value<double?> dose = const Value.absent(),
                required bool isDoseAnEstimate,
                Value<double?> estimatedDoseStandardDeviation =
                    const Value.absent(),
                Value<String?> units = const Value.absent(),
                required int experienceId,
                Value<String?> notes = const Value.absent(),
                Value<StomachFullness?> stomachFullness = const Value.absent(),
                Value<String?> consumerName = const Value.absent(),
                Value<int?> customUnitId = const Value.absent(),
              }) => IngestionsCompanion.insert(
                id: id,
                substanceName: substanceName,
                time: time,
                endTime: endTime,
                creationDate: creationDate,
                administrationRoute: administrationRoute,
                dose: dose,
                isDoseAnEstimate: isDoseAnEstimate,
                estimatedDoseStandardDeviation: estimatedDoseStandardDeviation,
                units: units,
                experienceId: experienceId,
                notes: notes,
                stomachFullness: stomachFullness,
                consumerName: consumerName,
                customUnitId: customUnitId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IngestionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({experienceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (experienceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.experienceId,
                                referencedTable: $$IngestionsTableReferences
                                    ._experienceIdTable(db),
                                referencedColumn: $$IngestionsTableReferences
                                    ._experienceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IngestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IngestionsTable,
      Ingestion,
      $$IngestionsTableFilterComposer,
      $$IngestionsTableOrderingComposer,
      $$IngestionsTableAnnotationComposer,
      $$IngestionsTableCreateCompanionBuilder,
      $$IngestionsTableUpdateCompanionBuilder,
      (Ingestion, $$IngestionsTableReferences),
      Ingestion,
      PrefetchHooks Function({bool experienceId})
    >;
typedef $$SubstanceCompanionsTableCreateCompanionBuilder =
    SubstanceCompanionsCompanion Function({
      required String substanceName,
      required AdaptiveColor color,
      Value<int> rowid,
    });
typedef $$SubstanceCompanionsTableUpdateCompanionBuilder =
    SubstanceCompanionsCompanion Function({
      Value<String> substanceName,
      Value<AdaptiveColor> color,
      Value<int> rowid,
    });

class $$SubstanceCompanionsTableFilterComposer
    extends Composer<_$AppDatabase, $SubstanceCompanionsTable> {
  $$SubstanceCompanionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get substanceName => $composableBuilder(
    column: $table.substanceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AdaptiveColor, AdaptiveColor, String>
  get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$SubstanceCompanionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubstanceCompanionsTable> {
  $$SubstanceCompanionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get substanceName => $composableBuilder(
    column: $table.substanceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubstanceCompanionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubstanceCompanionsTable> {
  $$SubstanceCompanionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get substanceName => $composableBuilder(
    column: $table.substanceName,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AdaptiveColor, String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);
}

class $$SubstanceCompanionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubstanceCompanionsTable,
          SubstanceCompanion,
          $$SubstanceCompanionsTableFilterComposer,
          $$SubstanceCompanionsTableOrderingComposer,
          $$SubstanceCompanionsTableAnnotationComposer,
          $$SubstanceCompanionsTableCreateCompanionBuilder,
          $$SubstanceCompanionsTableUpdateCompanionBuilder,
          (
            SubstanceCompanion,
            BaseReferences<
              _$AppDatabase,
              $SubstanceCompanionsTable,
              SubstanceCompanion
            >,
          ),
          SubstanceCompanion,
          PrefetchHooks Function()
        > {
  $$SubstanceCompanionsTableTableManager(
    _$AppDatabase db,
    $SubstanceCompanionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubstanceCompanionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubstanceCompanionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SubstanceCompanionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> substanceName = const Value.absent(),
                Value<AdaptiveColor> color = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubstanceCompanionsCompanion(
                substanceName: substanceName,
                color: color,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String substanceName,
                required AdaptiveColor color,
                Value<int> rowid = const Value.absent(),
              }) => SubstanceCompanionsCompanion.insert(
                substanceName: substanceName,
                color: color,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SubstanceCompanionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubstanceCompanionsTable,
      SubstanceCompanion,
      $$SubstanceCompanionsTableFilterComposer,
      $$SubstanceCompanionsTableOrderingComposer,
      $$SubstanceCompanionsTableAnnotationComposer,
      $$SubstanceCompanionsTableCreateCompanionBuilder,
      $$SubstanceCompanionsTableUpdateCompanionBuilder,
      (
        SubstanceCompanion,
        BaseReferences<
          _$AppDatabase,
          $SubstanceCompanionsTable,
          SubstanceCompanion
        >,
      ),
      SubstanceCompanion,
      PrefetchHooks Function()
    >;
typedef $$CustomSubstancesTableCreateCompanionBuilder =
    CustomSubstancesCompanion Function({
      Value<int> id,
      required String name,
      required String units,
      required String description,
    });
typedef $$CustomSubstancesTableUpdateCompanionBuilder =
    CustomSubstancesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> units,
      Value<String> description,
    });

class $$CustomSubstancesTableFilterComposer
    extends Composer<_$AppDatabase, $CustomSubstancesTable> {
  $$CustomSubstancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get units => $composableBuilder(
    column: $table.units,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomSubstancesTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomSubstancesTable> {
  $$CustomSubstancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get units => $composableBuilder(
    column: $table.units,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomSubstancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomSubstancesTable> {
  $$CustomSubstancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get units =>
      $composableBuilder(column: $table.units, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$CustomSubstancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomSubstancesTable,
          CustomSubstance,
          $$CustomSubstancesTableFilterComposer,
          $$CustomSubstancesTableOrderingComposer,
          $$CustomSubstancesTableAnnotationComposer,
          $$CustomSubstancesTableCreateCompanionBuilder,
          $$CustomSubstancesTableUpdateCompanionBuilder,
          (
            CustomSubstance,
            BaseReferences<
              _$AppDatabase,
              $CustomSubstancesTable,
              CustomSubstance
            >,
          ),
          CustomSubstance,
          PrefetchHooks Function()
        > {
  $$CustomSubstancesTableTableManager(
    _$AppDatabase db,
    $CustomSubstancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomSubstancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomSubstancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomSubstancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> units = const Value.absent(),
                Value<String> description = const Value.absent(),
              }) => CustomSubstancesCompanion(
                id: id,
                name: name,
                units: units,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String units,
                required String description,
              }) => CustomSubstancesCompanion.insert(
                id: id,
                name: name,
                units: units,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomSubstancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomSubstancesTable,
      CustomSubstance,
      $$CustomSubstancesTableFilterComposer,
      $$CustomSubstancesTableOrderingComposer,
      $$CustomSubstancesTableAnnotationComposer,
      $$CustomSubstancesTableCreateCompanionBuilder,
      $$CustomSubstancesTableUpdateCompanionBuilder,
      (
        CustomSubstance,
        BaseReferences<_$AppDatabase, $CustomSubstancesTable, CustomSubstance>,
      ),
      CustomSubstance,
      PrefetchHooks Function()
    >;
typedef $$ShulginRatingsTableCreateCompanionBuilder =
    ShulginRatingsCompanion Function({
      Value<int> id,
      Value<DateTime?> time,
      Value<DateTime?> creationDate,
      required ShulginRatingOption option,
      required int experienceId,
    });
typedef $$ShulginRatingsTableUpdateCompanionBuilder =
    ShulginRatingsCompanion Function({
      Value<int> id,
      Value<DateTime?> time,
      Value<DateTime?> creationDate,
      Value<ShulginRatingOption> option,
      Value<int> experienceId,
    });

final class $$ShulginRatingsTableReferences
    extends BaseReferences<_$AppDatabase, $ShulginRatingsTable, ShulginRating> {
  $$ShulginRatingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExperiencesTable _experienceIdTable(_$AppDatabase db) => db
      .experiences
      .createAlias('shulgin_ratings__experience_id__experiences__id');

  $$ExperiencesTableProcessedTableManager get experienceId {
    final $_column = $_itemColumn<int>('experience_id')!;

    final manager = $$ExperiencesTableTableManager(
      $_db,
      $_db.experiences,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_experienceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ShulginRatingsTableFilterComposer
    extends Composer<_$AppDatabase, $ShulginRatingsTable> {
  $$ShulginRatingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    ShulginRatingOption,
    ShulginRatingOption,
    String
  >
  get option => $composableBuilder(
    column: $table.option,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$ExperiencesTableFilterComposer get experienceId {
    final $$ExperiencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.experienceId,
      referencedTable: $db.experiences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExperiencesTableFilterComposer(
            $db: $db,
            $table: $db.experiences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShulginRatingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShulginRatingsTable> {
  $$ShulginRatingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get option => $composableBuilder(
    column: $table.option,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExperiencesTableOrderingComposer get experienceId {
    final $$ExperiencesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.experienceId,
      referencedTable: $db.experiences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExperiencesTableOrderingComposer(
            $db: $db,
            $table: $db.experiences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShulginRatingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShulginRatingsTable> {
  $$ShulginRatingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ShulginRatingOption, String> get option =>
      $composableBuilder(column: $table.option, builder: (column) => column);

  $$ExperiencesTableAnnotationComposer get experienceId {
    final $$ExperiencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.experienceId,
      referencedTable: $db.experiences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExperiencesTableAnnotationComposer(
            $db: $db,
            $table: $db.experiences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShulginRatingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShulginRatingsTable,
          ShulginRating,
          $$ShulginRatingsTableFilterComposer,
          $$ShulginRatingsTableOrderingComposer,
          $$ShulginRatingsTableAnnotationComposer,
          $$ShulginRatingsTableCreateCompanionBuilder,
          $$ShulginRatingsTableUpdateCompanionBuilder,
          (ShulginRating, $$ShulginRatingsTableReferences),
          ShulginRating,
          PrefetchHooks Function({bool experienceId})
        > {
  $$ShulginRatingsTableTableManager(
    _$AppDatabase db,
    $ShulginRatingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShulginRatingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShulginRatingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShulginRatingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> time = const Value.absent(),
                Value<DateTime?> creationDate = const Value.absent(),
                Value<ShulginRatingOption> option = const Value.absent(),
                Value<int> experienceId = const Value.absent(),
              }) => ShulginRatingsCompanion(
                id: id,
                time: time,
                creationDate: creationDate,
                option: option,
                experienceId: experienceId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime?> time = const Value.absent(),
                Value<DateTime?> creationDate = const Value.absent(),
                required ShulginRatingOption option,
                required int experienceId,
              }) => ShulginRatingsCompanion.insert(
                id: id,
                time: time,
                creationDate: creationDate,
                option: option,
                experienceId: experienceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShulginRatingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({experienceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (experienceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.experienceId,
                                referencedTable: $$ShulginRatingsTableReferences
                                    ._experienceIdTable(db),
                                referencedColumn:
                                    $$ShulginRatingsTableReferences
                                        ._experienceIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ShulginRatingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShulginRatingsTable,
      ShulginRating,
      $$ShulginRatingsTableFilterComposer,
      $$ShulginRatingsTableOrderingComposer,
      $$ShulginRatingsTableAnnotationComposer,
      $$ShulginRatingsTableCreateCompanionBuilder,
      $$ShulginRatingsTableUpdateCompanionBuilder,
      (ShulginRating, $$ShulginRatingsTableReferences),
      ShulginRating,
      PrefetchHooks Function({bool experienceId})
    >;
typedef $$TimedNotesTableCreateCompanionBuilder =
    TimedNotesCompanion Function({
      Value<int> id,
      required DateTime creationDate,
      required DateTime time,
      required String note,
      required AdaptiveColor color,
      required int experienceId,
      required bool isPartOfTimeline,
    });
typedef $$TimedNotesTableUpdateCompanionBuilder =
    TimedNotesCompanion Function({
      Value<int> id,
      Value<DateTime> creationDate,
      Value<DateTime> time,
      Value<String> note,
      Value<AdaptiveColor> color,
      Value<int> experienceId,
      Value<bool> isPartOfTimeline,
    });

final class $$TimedNotesTableReferences
    extends BaseReferences<_$AppDatabase, $TimedNotesTable, TimedNote> {
  $$TimedNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExperiencesTable _experienceIdTable(_$AppDatabase db) =>
      db.experiences.createAlias('timed_notes__experience_id__experiences__id');

  $$ExperiencesTableProcessedTableManager get experienceId {
    final $_column = $_itemColumn<int>('experience_id')!;

    final manager = $$ExperiencesTableTableManager(
      $_db,
      $_db.experiences,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_experienceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TimedNotesTableFilterComposer
    extends Composer<_$AppDatabase, $TimedNotesTable> {
  $$TimedNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AdaptiveColor, AdaptiveColor, String>
  get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isPartOfTimeline => $composableBuilder(
    column: $table.isPartOfTimeline,
    builder: (column) => ColumnFilters(column),
  );

  $$ExperiencesTableFilterComposer get experienceId {
    final $$ExperiencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.experienceId,
      referencedTable: $db.experiences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExperiencesTableFilterComposer(
            $db: $db,
            $table: $db.experiences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimedNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $TimedNotesTable> {
  $$TimedNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPartOfTimeline => $composableBuilder(
    column: $table.isPartOfTimeline,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExperiencesTableOrderingComposer get experienceId {
    final $$ExperiencesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.experienceId,
      referencedTable: $db.experiences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExperiencesTableOrderingComposer(
            $db: $db,
            $table: $db.experiences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimedNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimedNotesTable> {
  $$TimedNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AdaptiveColor, String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get isPartOfTimeline => $composableBuilder(
    column: $table.isPartOfTimeline,
    builder: (column) => column,
  );

  $$ExperiencesTableAnnotationComposer get experienceId {
    final $$ExperiencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.experienceId,
      referencedTable: $db.experiences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExperiencesTableAnnotationComposer(
            $db: $db,
            $table: $db.experiences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimedNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimedNotesTable,
          TimedNote,
          $$TimedNotesTableFilterComposer,
          $$TimedNotesTableOrderingComposer,
          $$TimedNotesTableAnnotationComposer,
          $$TimedNotesTableCreateCompanionBuilder,
          $$TimedNotesTableUpdateCompanionBuilder,
          (TimedNote, $$TimedNotesTableReferences),
          TimedNote,
          PrefetchHooks Function({bool experienceId})
        > {
  $$TimedNotesTableTableManager(_$AppDatabase db, $TimedNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimedNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimedNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimedNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> creationDate = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<AdaptiveColor> color = const Value.absent(),
                Value<int> experienceId = const Value.absent(),
                Value<bool> isPartOfTimeline = const Value.absent(),
              }) => TimedNotesCompanion(
                id: id,
                creationDate: creationDate,
                time: time,
                note: note,
                color: color,
                experienceId: experienceId,
                isPartOfTimeline: isPartOfTimeline,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime creationDate,
                required DateTime time,
                required String note,
                required AdaptiveColor color,
                required int experienceId,
                required bool isPartOfTimeline,
              }) => TimedNotesCompanion.insert(
                id: id,
                creationDate: creationDate,
                time: time,
                note: note,
                color: color,
                experienceId: experienceId,
                isPartOfTimeline: isPartOfTimeline,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimedNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({experienceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (experienceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.experienceId,
                                referencedTable: $$TimedNotesTableReferences
                                    ._experienceIdTable(db),
                                referencedColumn: $$TimedNotesTableReferences
                                    ._experienceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TimedNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimedNotesTable,
      TimedNote,
      $$TimedNotesTableFilterComposer,
      $$TimedNotesTableOrderingComposer,
      $$TimedNotesTableAnnotationComposer,
      $$TimedNotesTableCreateCompanionBuilder,
      $$TimedNotesTableUpdateCompanionBuilder,
      (TimedNote, $$TimedNotesTableReferences),
      TimedNote,
      PrefetchHooks Function({bool experienceId})
    >;
typedef $$CustomUnitsTableCreateCompanionBuilder =
    CustomUnitsCompanion Function({
      Value<int> id,
      required String substanceName,
      required String name,
      required DateTime creationDate,
      required String administrationRoute,
      Value<double?> dose,
      Value<double?> estimatedDoseStandardDeviation,
      required bool isEstimate,
      required bool isArchived,
      required String unit,
      Value<String?> unitPlural,
      required String originalUnit,
      required String note,
    });
typedef $$CustomUnitsTableUpdateCompanionBuilder =
    CustomUnitsCompanion Function({
      Value<int> id,
      Value<String> substanceName,
      Value<String> name,
      Value<DateTime> creationDate,
      Value<String> administrationRoute,
      Value<double?> dose,
      Value<double?> estimatedDoseStandardDeviation,
      Value<bool> isEstimate,
      Value<bool> isArchived,
      Value<String> unit,
      Value<String?> unitPlural,
      Value<String> originalUnit,
      Value<String> note,
    });

class $$CustomUnitsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomUnitsTable> {
  $$CustomUnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get substanceName => $composableBuilder(
    column: $table.substanceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get administrationRoute => $composableBuilder(
    column: $table.administrationRoute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedDoseStandardDeviation =>
      $composableBuilder(
        column: $table.estimatedDoseStandardDeviation,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<bool> get isEstimate => $composableBuilder(
    column: $table.isEstimate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitPlural => $composableBuilder(
    column: $table.unitPlural,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalUnit => $composableBuilder(
    column: $table.originalUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomUnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomUnitsTable> {
  $$CustomUnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get substanceName => $composableBuilder(
    column: $table.substanceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get administrationRoute => $composableBuilder(
    column: $table.administrationRoute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedDoseStandardDeviation =>
      $composableBuilder(
        column: $table.estimatedDoseStandardDeviation,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<bool> get isEstimate => $composableBuilder(
    column: $table.isEstimate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitPlural => $composableBuilder(
    column: $table.unitPlural,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalUnit => $composableBuilder(
    column: $table.originalUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomUnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomUnitsTable> {
  $$CustomUnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get substanceName => $composableBuilder(
    column: $table.substanceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get administrationRoute => $composableBuilder(
    column: $table.administrationRoute,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dose =>
      $composableBuilder(column: $table.dose, builder: (column) => column);

  GeneratedColumn<double> get estimatedDoseStandardDeviation =>
      $composableBuilder(
        column: $table.estimatedDoseStandardDeviation,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get isEstimate => $composableBuilder(
    column: $table.isEstimate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get unitPlural => $composableBuilder(
    column: $table.unitPlural,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalUnit => $composableBuilder(
    column: $table.originalUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$CustomUnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomUnitsTable,
          CustomUnit,
          $$CustomUnitsTableFilterComposer,
          $$CustomUnitsTableOrderingComposer,
          $$CustomUnitsTableAnnotationComposer,
          $$CustomUnitsTableCreateCompanionBuilder,
          $$CustomUnitsTableUpdateCompanionBuilder,
          (
            CustomUnit,
            BaseReferences<_$AppDatabase, $CustomUnitsTable, CustomUnit>,
          ),
          CustomUnit,
          PrefetchHooks Function()
        > {
  $$CustomUnitsTableTableManager(_$AppDatabase db, $CustomUnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomUnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomUnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomUnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> substanceName = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> creationDate = const Value.absent(),
                Value<String> administrationRoute = const Value.absent(),
                Value<double?> dose = const Value.absent(),
                Value<double?> estimatedDoseStandardDeviation =
                    const Value.absent(),
                Value<bool> isEstimate = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String?> unitPlural = const Value.absent(),
                Value<String> originalUnit = const Value.absent(),
                Value<String> note = const Value.absent(),
              }) => CustomUnitsCompanion(
                id: id,
                substanceName: substanceName,
                name: name,
                creationDate: creationDate,
                administrationRoute: administrationRoute,
                dose: dose,
                estimatedDoseStandardDeviation: estimatedDoseStandardDeviation,
                isEstimate: isEstimate,
                isArchived: isArchived,
                unit: unit,
                unitPlural: unitPlural,
                originalUnit: originalUnit,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String substanceName,
                required String name,
                required DateTime creationDate,
                required String administrationRoute,
                Value<double?> dose = const Value.absent(),
                Value<double?> estimatedDoseStandardDeviation =
                    const Value.absent(),
                required bool isEstimate,
                required bool isArchived,
                required String unit,
                Value<String?> unitPlural = const Value.absent(),
                required String originalUnit,
                required String note,
              }) => CustomUnitsCompanion.insert(
                id: id,
                substanceName: substanceName,
                name: name,
                creationDate: creationDate,
                administrationRoute: administrationRoute,
                dose: dose,
                estimatedDoseStandardDeviation: estimatedDoseStandardDeviation,
                isEstimate: isEstimate,
                isArchived: isArchived,
                unit: unit,
                unitPlural: unitPlural,
                originalUnit: originalUnit,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomUnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomUnitsTable,
      CustomUnit,
      $$CustomUnitsTableFilterComposer,
      $$CustomUnitsTableOrderingComposer,
      $$CustomUnitsTableAnnotationComposer,
      $$CustomUnitsTableCreateCompanionBuilder,
      $$CustomUnitsTableUpdateCompanionBuilder,
      (
        CustomUnit,
        BaseReferences<_$AppDatabase, $CustomUnitsTable, CustomUnit>,
      ),
      CustomUnit,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExperiencesTableTableManager get experiences =>
      $$ExperiencesTableTableManager(_db, _db.experiences);
  $$IngestionsTableTableManager get ingestions =>
      $$IngestionsTableTableManager(_db, _db.ingestions);
  $$SubstanceCompanionsTableTableManager get substanceCompanions =>
      $$SubstanceCompanionsTableTableManager(_db, _db.substanceCompanions);
  $$CustomSubstancesTableTableManager get customSubstances =>
      $$CustomSubstancesTableTableManager(_db, _db.customSubstances);
  $$ShulginRatingsTableTableManager get shulginRatings =>
      $$ShulginRatingsTableTableManager(_db, _db.shulginRatings);
  $$TimedNotesTableTableManager get timedNotes =>
      $$TimedNotesTableTableManager(_db, _db.timedNotes);
  $$CustomUnitsTableTableManager get customUnits =>
      $$CustomUnitsTableTableManager(_db, _db.customUnits);
}

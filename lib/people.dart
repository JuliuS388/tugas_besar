class Person {
  final String name;
  final String phone;
  final String car;
  const Person(this.name, this.phone, this.car);
}

final List<Person> people = _people
    .map((e) =>
        Person(e['name'] as String, e['phone'] as String, e['car'] as String))
    .toList(growable: false);

final List<Map<String, Object>> _people = [
  {
    "_id": "66fd4e8b73d626f60cbe38fc",
    "index": 0,
    "guid": "12174a5b-2587-409f-93d4-3379795f95db",
    "isActive": false,
    "balance": "\$2,342.83",
    "car": "Toyota Ayla",
    "age": 36,
    "eyeColor": "brown",
    "name": "Sigit Las",
    "gender": "male",
    "company": "NSPIRE",
    "email": "sigitlas@gmail.com",
    "phone": "08572574812",
    "address": "252 School Lane, Joes, Indiana, 8515",
    "about":
        "Consectetur amet anim sit proident ullamco et id. Deserunt tempor in reprehenderit laboris ipsum excepteur culpa. Lorem excepteur laborum nulla excepteur elit. Dolor fugiat ullamco consequat enim labore magna id dolore in.\r\n",
    "registered": "2022-04-20T12:01:36 -07:00",
    "latitude": 71.703507,
    "longitude": 65.815382,
    "tags": [
      "excepteur",
      "mollit",
      "cillum",
      "pariatur",
      "duis",
      "qui",
      "excepteur"
    ],
    "friends": [
      {"id": 0, "name": "Hannah Whitley"},
      {"id": 1, "name": "Katina Gregory"},
      {"id": 2, "name": "Emilia Roberson"}
    ],
    "greeting": "Hello, Sigit! You have 9 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fd4e8b2a5a48f84fc8043b",
    "index": 1,
    "guid": "036c40d3-014f-4a7f-ba15-d652f0994607",
    "isActive": true,
    "balance": "\$3,178.32",
    "car": "Toyota Innova",
    "age": 22,
    "eyeColor": "brown",
    "name": "Parto Kompor",
    "gender": "male",
    "company": "ZORROMOP",
    "email": "partokompor69@gmail.com",
    "phone": "08789352644",
    "address": "992 Harman Street, Tecolotito, Puerto Rico, 3999",
    "about":
        "Ea est deserunt et elit dolore officia mollit nulla culpa ut sint nisi. Commodo laboris nisi deserunt dolore culpa nostrud aute quis nostrud aliqua reprehenderit mollit. Consequat cillum Lorem fugiat ex est amet. Nostrud sint duis nisi culpa eiusmod labore eu mollit eu tempor nisi labore. Nulla amet nulla fugiat nulla fugiat irure est cillum consectetur consequat veniam aute. Voluptate ut aliqua cupidatat velit anim esse proident occaecat nisi occaecat deserunt incididunt nisi. Eiusmod duis est est sit commodo proident mollit aliquip fugiat.\r\n",
    "registered": "2023-11-06T01:58:27 -07:00",
    "latitude": 80.606784,
    "longitude": 85.87788,
    "tags": [
      "consectetur",
      "velit",
      "adipisicing",
      "est",
      "laborum",
      "ex",
      "magna"
    ],
    "friends": [
      {"id": 0, "name": "Ross Harrison"},
      {"id": 1, "name": "Booker Whitaker"},
      {"id": 2, "name": "Phelps Skinner"}
    ],
    "greeting": "Hello, Parto Kompor! You have 6 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "66fd4e8b53c1158e5b4e3f1e",
    "index": 2,
    "guid": "59e1391d-db05-4822-af83-a0d0127ac336",
    "isActive": true,
    "balance": "\$3,901.27",
    "car": "Toyota Corolla",
    "age": 37,
    "eyeColor": "brown",
    "name": "Sapto Ketdah",
    "gender": "male",
    "company": "JOVIOLD",
    "email": "saptoketdah@gmail.com",
    "phone": "085687462291",
    "address": "975 Anthony Street, Hemlock, Iowa, 4963",
    "about":
        "Consequat ullamco dolor sint ut commodo est. Dolor adipisicing labore sunt reprehenderit sit et excepteur ipsum mollit est eiusmod veniam dolor. Ea ex eiusmod in ex. Fugiat voluptate cillum do reprehenderit. Velit velit exercitation esse irure adipisicing. Qui aute sint exercitation ullamco amet.\r\n",
    "registered": "2019-04-16T10:10:38 -07:00",
    "latitude": 80.62992,
    "longitude": 91.539043,
    "tags": ["mollit", "velit", "non", "ea", "laborum", "irure", "duis"],
    "friends": [
      {"id": 0, "name": "Marissa Cortez"},
      {"id": 1, "name": "Doris Gilliam"},
      {"id": 2, "name": "Owens Underwood"}
    ],
    "greeting": "Hello, Sapto Ketdah! You have 6 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "66fd4e8b77f89250db5eac26",
    "index": 3,
    "guid": "cc276d9f-ee52-4bce-9f52-b4c73573606c",
    "isActive": false,
    "balance": "\$2,504.62",
    "car": "Toyota Yaris",
    "age": 39,
    "eyeColor": "black",
    "name": "Agung Bubut",
    "gender": "male",
    "company": "DIGIRANG",
    "email": "agungbubut351@gmail.com",
    "phone": "089854621233",
    "address": "173 Pleasant Place, Waumandee, Maryland, 1431",
    "about":
        "Amet occaecat Lorem consequat non adipisicing occaecat commodo dolore cillum laboris. Occaecat nisi cillum veniam tempor dolor consectetur enim occaecat ullamco eiusmod. Fugiat eu laboris exercitation nostrud laboris. Do fugiat est et officia proident duis deserunt ut incididunt anim incididunt laboris. Non aliquip tempor velit pariatur ullamco. Laborum commodo sunt ad ea sint. Labore duis aliquip in ad ad ullamco deserunt consectetur velit veniam eiusmod culpa.\r\n",
    "registered": "2015-12-17T11:55:35 -07:00",
    "latitude": -44.780119,
    "longitude": -124.157899,
    "tags": [
      "consectetur",
      "in",
      "excepteur",
      "do",
      "qui",
      "consectetur",
      "minim"
    ],
    "friends": [
      {"id": 0, "name": "Frederick Huff"},
      {"id": 1, "name": "Carr Allison"},
      {"id": 2, "name": "Dionne Barrera"}
    ],
    "greeting": "Hello, Agung Bubut! You have 8 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fd4e8ba547904e9f26a94b",
    "index": 4,
    "guid": "b3b3fd3a-e529-419a-86b3-6a59a2205c14",
    "isActive": true,
    "balance": "\$2,616.79",
    "car": "Suzuki Karimun",
    "age": 30,
    "eyeColor": "brown",
    "name": "Prapto Wiryo",
    "gender": "male",
    "company": "AUTOGRATE",
    "email": "praptowiryo76@gmail.com",
    "phone": "08986524431",
    "address": "154 Java Street, Brutus, Massachusetts, 5493",
    "about":
        "Cillum enim mollit qui est adipisicing. Est aliqua laboris nostrud voluptate sit laborum fugiat aliquip. Adipisicing mollit culpa ut voluptate. Consequat anim laboris deserunt est qui anim elit ad tempor irure occaecat proident.\r\n",
    "registered": "2020-02-27T12:34:53 -07:00",
    "latitude": 45.543064,
    "longitude": 176.000663,
    "tags": [
      "labore",
      "reprehenderit",
      "consequat",
      "aliquip",
      "tempor",
      "id",
      "sunt"
    ],
    "friends": [
      {"id": 0, "name": "Nunez Matthews"},
      {"id": 1, "name": "Callahan Mueller"},
      {"id": 2, "name": "Berger Suarez"}
    ],
    "greeting": "Hello, Prapto Wiryo! You have 5 unread messages.",
    "favoriteFruit": "strawberry"
  }
];

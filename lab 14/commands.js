use shop
db.createCollection("users")
db.collection_name.drop()

db.createCollection("delivery")
db.createCollection("goods")
db.createCollection("article")
db.createCollection("order")
db.createCollection("comment")

db.users.update({}, {})

db.users.insertOne(
  {
    "first_name": "Jonh",
    "last_name": "Charles",
    "email": "john@test.com",
    "password": "123456",
    "registration_date": new Date('2020-01-04'),
    "scope": []
  }
)
//add orders
db.users.insertMany([
  {
    "first_name": "Jonh",
    "last_name": "Charles",
    "email": "john@test.com",
    "password": "qwerty",
    "registration_date": new Date('2020-01-04'),
    "scope": []
  },
  {
    "first_name": "Diana",
    "last_name": "Benington",
    "email": "linkin@test.com",
    "password": "123qwer",
    "registration_date": new Date('2020-01-04'),
    "scope": []
  }
])

db.comment.insertMany([
  {
    "user_id": ObjectId("5ec43028ede886ae083317ff"),
    "text": "Comments about how far of goods this is",
    "rate": 3
  },
  {
    "user_id":  ObjectId("5ec43028ede886ae08331800"),
    "text": "Exelent",
    "rate": 5
  },
])

db.goods.insertMany([
  {
    "code": "125464",
    "depot": "vul. City",
    "amount": 3,
  },
  {
    "code": "65465421",
    "depot": "vul. City",
    "amount": 1,
  }
])

db.article.insertMany([
  {
    "name": "Computer MSI 1245",
    "price": 17400,
    "goods": [
      ObjectId("5ec43214ede886ae08331803"),
      ObjectId("5ec43214ede886ae08331804")],
    "groups": ["Computer", "MSI", "GTX 1050TI"],
    "description": "A long description about thais peace of technology.",
    "photos": [],
    "comments": [ObjectId("5ec43099ede886ae08331801")]
  },
  {
    "name": "iPhone 7S",
    "price": 23600,
    "goods": [],
    "groups": ["OverPrice", "Apple", "iPhone"],
    "description": "That is peace of technology.",
    "photos": [],
    "comments": [ObjectId("5ec43099ede886ae08331802")]
  }
])

db.delivery.insertMany([
  {
    "from": "Ukraine",
    "destination": "Sykhivs`ka street 18",
    "status": "done"
  },
  {
    "from": "Sykhivs`ka street 18",
    "destination": "Bandery str. 1",
    "status": "In progress"
  }
])

db.order.insertMany([
  {
//    "user_id": ObjectId("5ec43028ede886ae083317ff"),
    "ordered": new Date("2020-02-14"),
    "accomplished": new Date("2020-02-21"),
    "status": "done",
    "payment": "cash",
    "delivery_type": "on feet",
    "goods": [ ObjectId("5ec43214ede886ae08331803")]
  },
  {
//    "user_id": ObjectId("5ec43028ede886ae083317ff") ,
    "ordered": new Date("2020-04-04"),
    "accomplished": null,
    "status": "in progress",
    "payment": "card",
    "delivery_type": "by train",
    "goods": [ObjectId("5ec43214ede886ae08331804")]
  }
])

/*
* adding field
*/
db.users.updateOne(
  {
    "_id": ObjectId("5ec43028ede886ae083317ff")
  },
  {$set:{
    "orders": [ObjectId("5ec43d0dede886ae08331809")]
  }}
)

db.users.updateOne(
  {
    "_id": ObjectId("5ec43028ede886ae08331800")
  },
  {$set:{
    "orders": [ ObjectId("5ec43d0dede886ae0833180a")]
  }}
)

db.order.updateMany(
  {
    "user_id": ObjectId("5ec43028ede886ae083317ff"),
    "user_id": ObjectId("5ec43028ede886ae083317ff")
  },
  {$unset:{
    "user_id": ""
  }}
)
// RUN this
db.goods.updateMany(
  {
    "amount": 3
  },
  {$set:{
    "random_field": ["hjdgjfsagdfkjgsdjfha"]
  }}
)

db.users.find(
  {
    $or: [
      {password: {$lt: 6}}
    ]
  },
  {_id: 0}
)
.sort({"email": -1})
// $gte >=
// $ne !=
db.users.find(
  {
    orders: {$exists: true}
  },
  {_id: 0}
)

// col: {$size: 2}
// "groups.0s": "Computer"
var sm_goods = db.goods.findOne({code: "125464", amount: {$gt: 0}});
sm_goods.amount = sm_goods.amount + 1;
// db.goods.updateOne({code: "125464", amount: {$gt: 0}}, {amount:  sm_goods + 1 })

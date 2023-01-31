import 'dart:io';

import 'package:nvectech/constant/constant.dart';
import 'package:sqflite/sqflite.dart';

import 'notification_bean.dart';

const _version = 1;//数据库版本号
const _databaseName = "Notifications.db";//数据库名称
const _tableName = "notifications_table";//表名称
const _tableId = "notification_id";//主键
const _deviceName = "device_name";//名称
const _targetDistance = "target_distance";//距离
const _targetType = "target_type";// 类型
const _notificationDate = "notification_date";// 日期
const _notificationTime = "notification_time";// 时间

class SqfLiteQueueData{

  SqfLiteQueueData.internal();

  //数据库句柄
  late Database _database;
  Future<Database> get database async {
    String path = "${await getDatabasesPath()}/$_databaseName";
    _database = await openDatabase(path, version: _version,
      onConfigure: (Database db){
        print("数据库创建前、降级前、升级前调用");
      },
      onDowngrade: (Database db, int version, int x){
        print("降级时调用");
      },
      onUpgrade: (Database db, int version, int x){
        print("升级时调用");
      },
      onCreate: (Database db, int version) async {
        print("创建时调用");
      },
      onOpen: (Database db) async {
        print("重新打开时调用");
        await _createTable(db, '''create table if not exists $_tableName (
        $_tableId integer primary key,$_deviceName text,$_targetDistance INTEGER,
        $_targetType INTEGER,$_notificationDate text,$_notificationTime text)''');
      },
    );
    return _database;
  }

  /// 创建表
  Future<void> _createTable(Database db, String sql) async{
    var batch = db.batch();
    batch.execute(sql);
    await batch.commit();
  }

  /// 添加数据
  static Future insertData(NotificationBean notificationBean) async{
    Database db = await SqfLiteQueueData.internal().open();
    db.transaction((txn) async{
      await txn.rawInsert("insert or replace into $_tableName ($_tableId,$_deviceName,$_targetDistance,$_targetType, $_notificationDate, $_notificationTime) values (null,?,?,?,?,?)",
          [notificationBean.deviceName,notificationBean.distance, notificationBean.type, notificationBean.date, notificationBean.time]);
    });
    await db.batch().commit();

    await SqfLiteQueueData.internal().close();
  }

  /// 根据id删除该条记录
  static Future deleteData(int id) async{
    Database db = await SqfLiteQueueData.internal().open();
    db.transaction((txn) async{
      txn.rawDelete("delete from $_tableName where $_tableId = ?",[id]);
    });
    await db.batch().commit();

    await SqfLiteQueueData.internal().close();
  }

  /// 清空数据
  static Future deleteAll() async{
    Database db = await SqfLiteQueueData.internal().open();
    db.transaction((txn) async{
      txn.rawDelete("delete from $_tableName");
    });
    await db.batch().commit();

    await SqfLiteQueueData.internal().close();
  }

  /// 删除某一天的记录
  static Future deleteOneDay(String notificationDate) async{
    Database db = await SqfLiteQueueData.internal().open();
    db.transaction((txn) async{
      txn.rawDelete("delete from $_tableName where $_notificationDate = ?",[notificationDate]);
    });
    await db.batch().commit();

    await SqfLiteQueueData.internal().close();
  }

  /// 删除日期之前的记录
  static Future deleteOverdue(String notificationDate) async{
    Database db = await SqfLiteQueueData.internal().open();
    db.transaction((txn) async{
      txn.rawDelete("delete from $_tableName where $_notificationDate < ?",[notificationDate]);
    });
    await db.batch().commit();

    await SqfLiteQueueData.internal().close();
  }

  /// 查询所有数据
  static Future<List<Map<String, dynamic>>> searchAllData() async {
    Database db = await SqfLiteQueueData.internal().open();
    List<Map<String, dynamic>> maps = await db.rawQuery("select * from $_tableName");
    print(maps);

    await SqfLiteQueueData.internal().close();
    return maps;
  }

  /// 查询指定数据
  static Future<List<Map<String, dynamic>>> searchData(String deviceName, int targetType, String notificationDate) async {
    Database db = await SqfLiteQueueData.internal().open();
    List<Map<String, dynamic>> maps = [];
    print('deviceName:$deviceName, targetType:$targetType, notificationDate:$notificationDate');
    if(targetType == 1){
      maps = await db.rawQuery(
          "select * from $_tableName where $_deviceName = ? and $_targetType != ${Constant.typePerson} and $_notificationDate = ? order by $_tableId desc",
          [deviceName, notificationDate]);
    } else if(targetType == 2){
      maps = await db.rawQuery(
          "select * from $_tableName where $_deviceName = ? and $_targetType = ${Constant.typePerson} and $_notificationDate = ? order by $_tableId desc",
          [deviceName, notificationDate]);
    } else {
      maps = await db.rawQuery(
          "select * from $_tableName where $_deviceName = ? and $_notificationDate = ? order by $_tableId desc",
          [deviceName, notificationDate]);
    }

    print(maps);

    await SqfLiteQueueData.internal().close();
    return maps;
  }

  /// 查询设备数据
  static Future<List<Map<String, dynamic>>> searchDeviceNameList() async {
    Database db = await SqfLiteQueueData.internal().open();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "select distinct $_deviceName from $_tableName order by $_tableId desc");
    print(maps);

    await SqfLiteQueueData.internal().close();
    return maps;
  }

  /// 查询日期数据
  static Future<List<Map<String, dynamic>>> searchNotificationDateList() async {
    Database db = await SqfLiteQueueData.internal().open();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "select distinct $_notificationDate from $_tableName order by $_tableId desc");
    print(maps);

    await SqfLiteQueueData.internal().close();
    return maps;
  }


  ///打开
  Future<Database> open() async{
    return await database;
  }

  ///关闭
  Future<void> close() async {
    var db = await database;
    return db.close();
  }

  ///删除数据库表
  static Future<void> deleteDataTable() async {
    Database db = await SqfLiteQueueData.internal().open();
    //1、普通删除
    //await db.rawDelete("drop table $_tableName");
    //2、事务删除
    db.transaction((txn) async{
      txn.rawDelete("drop table $_tableName");
    });
    await db.batch().commit();

    await SqfLiteQueueData.internal().close();
  }

  ///删除数据库文件
  static Future<void> deleteDataBaseFile() async {
    await SqfLiteQueueData.internal().close();
    String path = "${await getDatabasesPath()}/$_databaseName";
    File file = File(path);
    if(await file.exists()){
      file.delete();
    }
  }
}

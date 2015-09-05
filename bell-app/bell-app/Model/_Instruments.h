// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Instruments.h instead.

#import <CoreData/CoreData.h>

extern const struct InstrumentsAttributes {
	__unsafe_unretained NSString *category_id;
	__unsafe_unretained NSString *del_flg;
	__unsafe_unretained NSString *detail;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *image_url;
	__unsafe_unretained NSString *name;
} InstrumentsAttributes;

@interface InstrumentsID : NSManagedObjectID {}
@end

@interface _Instruments : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) InstrumentsID* objectID;

@property (nonatomic, strong) NSNumber* category_id;

@property (atomic) int16_t category_idValue;
- (int16_t)category_idValue;
- (void)setCategory_idValue:(int16_t)value_;

//- (BOOL)validateCategory_id:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* del_flg;

@property (atomic) int16_t del_flgValue;
- (int16_t)del_flgValue;
- (void)setDel_flgValue:(int16_t)value_;

//- (BOOL)validateDel_flg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* detail;

//- (BOOL)validateDetail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int16_t idValue;
- (int16_t)idValue;
- (void)setIdValue:(int16_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* image_url;

//- (BOOL)validateImage_url:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@end

@interface _Instruments (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveCategory_id;
- (void)setPrimitiveCategory_id:(NSNumber*)value;

- (int16_t)primitiveCategory_idValue;
- (void)setPrimitiveCategory_idValue:(int16_t)value_;

- (NSNumber*)primitiveDel_flg;
- (void)setPrimitiveDel_flg:(NSNumber*)value;

- (int16_t)primitiveDel_flgValue;
- (void)setPrimitiveDel_flgValue:(int16_t)value_;

- (NSString*)primitiveDetail;
- (void)setPrimitiveDetail:(NSString*)value;

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int16_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int16_t)value_;

- (NSString*)primitiveImage_url;
- (void)setPrimitiveImage_url:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end

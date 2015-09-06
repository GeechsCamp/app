// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Instruments.h instead.

#import <CoreData/CoreData.h>

extern const struct InstrumentsAttributes {
	__unsafe_unretained NSString *category_name;
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

@property (nonatomic, strong) NSString* category_name;

//- (BOOL)validateCategory_name:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* del_flg;

//- (BOOL)validateDel_flg:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* detail;

//- (BOOL)validateDetail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* id;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* image_url;

//- (BOOL)validateImage_url:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@end

@interface _Instruments (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCategory_name;
- (void)setPrimitiveCategory_name:(NSString*)value;

- (NSString*)primitiveDel_flg;
- (void)setPrimitiveDel_flg:(NSString*)value;

- (NSString*)primitiveDetail;
- (void)setPrimitiveDetail:(NSString*)value;

- (NSString*)primitiveId;
- (void)setPrimitiveId:(NSString*)value;

- (NSString*)primitiveImage_url;
- (void)setPrimitiveImage_url:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end

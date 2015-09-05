// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Instruments.m instead.

#import "_Instruments.h"

const struct InstrumentsAttributes InstrumentsAttributes = {
	.category_id = @"category_id",
	.del_flg = @"del_flg",
	.detail = @"detail",
	.id = @"id",
	.image_url = @"image_url",
	.name = @"name",
};

@implementation InstrumentsID
@end

@implementation _Instruments

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Instruments" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Instruments";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Instruments" inManagedObjectContext:moc_];
}

- (InstrumentsID*)objectID {
	return (InstrumentsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"category_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"category_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"del_flgValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"del_flg"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic category_id;

- (int16_t)category_idValue {
	NSNumber *result = [self category_id];
	return [result shortValue];
}

- (void)setCategory_idValue:(int16_t)value_ {
	[self setCategory_id:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveCategory_idValue {
	NSNumber *result = [self primitiveCategory_id];
	return [result shortValue];
}

- (void)setPrimitiveCategory_idValue:(int16_t)value_ {
	[self setPrimitiveCategory_id:[NSNumber numberWithShort:value_]];
}

@dynamic del_flg;

- (int16_t)del_flgValue {
	NSNumber *result = [self del_flg];
	return [result shortValue];
}

- (void)setDel_flgValue:(int16_t)value_ {
	[self setDel_flg:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveDel_flgValue {
	NSNumber *result = [self primitiveDel_flg];
	return [result shortValue];
}

- (void)setPrimitiveDel_flgValue:(int16_t)value_ {
	[self setPrimitiveDel_flg:[NSNumber numberWithShort:value_]];
}

@dynamic detail;

@dynamic id;

- (int16_t)idValue {
	NSNumber *result = [self id];
	return [result shortValue];
}

- (void)setIdValue:(int16_t)value_ {
	[self setId:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result shortValue];
}

- (void)setPrimitiveIdValue:(int16_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithShort:value_]];
}

@dynamic image_url;

@dynamic name;

@end


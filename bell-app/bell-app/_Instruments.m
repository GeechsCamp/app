// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Instruments.m instead.

#import "_Instruments.h"

const struct InstrumentsAttributes InstrumentsAttributes = {
	.category_name = @"category_name",
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

	return keyPaths;
}

@dynamic category_name;

@dynamic del_flg;

@dynamic detail;

@dynamic id;

@dynamic image_url;

@dynamic name;

@end


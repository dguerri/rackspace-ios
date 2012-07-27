//
//  OSComputeEndpoint.m
//  OpenStack
//
//  Created by Mike Mayo on 7/26/12.
//
//

#import "OSComputeEndpoint.h"

@implementation OSComputeEndpoint

#pragma mark - Serialization

- (id)copyWithZone:(NSZone *)zone {
    OSComputeEndpoint *copy = [[OSComputeEndpoint allocWithZone:zone] init];
    copy.region = self.region;
    copy.tenantId = self.tenantId;
    copy.publicURL = self.publicURL;
    copy.versionId = self.versionId;
    copy.servers = self.servers;
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.region forKey:@"region"];
    [coder encodeObject:self.tenantId forKey:@"tenantId"];
    [coder encodeObject:self.publicURL forKey:@"publicURL"];
    [coder encodeObject:self.versionId forKey:@"versionId"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.region = [[coder decodeObjectForKey:@"region"] retain];
        self.tenantId = [[coder decodeObjectForKey:@"tenantId"] retain];
        self.publicURL = [[coder decodeObjectForKey:@"publicURL"] retain];
        self.versionId = [[coder decodeObjectForKey:@"versionId"] retain];
    }
    return self;
}

#pragma mark - JSON

- (void)populateWithJSON:(NSDictionary *)dict {
    self.tenantId = [dict objectForKey:@"tenantId"];
    self.region = [dict objectForKey:@"region"];
    self.publicURL = [NSURL URLWithString:[dict objectForKey:@"publicURL"]];
    self.versionId = [dict objectForKey:@"versionId"];
}

- (id)initWithJSONDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self populateWithJSON:dict];
    }
    return self;
}

+ (OSComputeEndpoint *)fromJSON:(NSDictionary *)dict {
    OSComputeEndpoint *endpoint = [[OSComputeEndpoint alloc] initWithJSONDict:dict];
    return [endpoint autorelease];
}

#pragma mark - KVO

- (void)addServersObject:(Server *)object {
    if (!self.servers) {
        self.servers = [[[NSMutableDictionary alloc] init] autorelease];
    }
    [self.servers setObject:object forKey:object.identifier];
}

- (void)removeServersObject:(Server *)object {
    [self.servers removeObjectForKey:object.identifier];
}

#pragma mark - Memory Management

- (void)dealloc {
    [_region release];
    [_tenantId release];
    [_publicURL release];
    [_versionId release];
    [_servers release];
    [super dealloc];
}

@end

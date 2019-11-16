//
//  CMarkParser.m
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "CMarkParser.h"
#import "MarkdiumTypes.h"

void cmarkGFMCoreExtensionsEnsureRegistered(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cmark_gfm_core_extensions_ensure_registered();
    });
}

NSString *getNodeTypeString(cmark_node *node) {
    NSString *output = nil;
    const char *ptr = cmark_node_get_type_string(node);
    if (ptr) {
        output = [NSString stringWithUTF8String:ptr];
    }

    return output;
}

NSString *getNodeLiteral(cmark_node *node) {
    NSString *output = nil;
    const char *ptr = cmark_node_get_literal(node);
    if (ptr) {
        output = [NSString stringWithUTF8String:ptr];
    }

    return output;
}

extern cmark_syntax_extension *create_tagfilter_extension(void);
extern cmark_syntax_extension *create_autolink_extension(void);
extern cmark_syntax_extension *create_strikethrough_extension(void);
extern cmark_syntax_extension *create_tasklist_extension(void);
extern cmark_syntax_extension *create_table_extension(void);

void cmarkEnableGFM(cmark_parser *parser, int extensions) {
    if (extensions & MDExtensionTagFilter) cmark_parser_attach_syntax_extension(parser, create_tagfilter_extension());
    if (extensions & MDExtensionAutolink) cmark_parser_attach_syntax_extension(parser, create_autolink_extension());
    if (extensions & MDExtensionStrikethrough) cmark_parser_attach_syntax_extension(parser, create_strikethrough_extension());
    if (extensions & MDExtensionTasklist) cmark_parser_attach_syntax_extension(parser, create_tasklist_extension());
    if (extensions & MDExtensionTable) cmark_parser_attach_syntax_extension(parser, create_table_extension());
}

cmark_node *cmarkParseString(NSString *string, int options, int extensions) {
    if (!string) {
        return NULL;
    }

    cmarkGFMCoreExtensionsEnsureRegistered();

    cmark_parser *parser = cmark_parser_new(options);
    if (!parser) {
        return NULL;
    }

    cmarkEnableGFM(parser, extensions);

    const char *utf8String = string.UTF8String;
    cmark_parser_feed(parser, utf8String, strlen(utf8String));
    cmark_node *node = cmark_parser_finish(parser);
    cmark_parser_free(parser);

    return node;
}

cmark_node *cmarkParsePath(NSString *path, int options, int extensions) {
    if (!path || ![NSFileManager.defaultManager fileExistsAtPath:path]) {
        return NULL;
    }

    cmarkGFMCoreExtensionsEnsureRegistered();

    cmark_parser *parser = cmark_parser_new(options);
    if (!parser) {
        return NULL;
    }

    cmarkEnableGFM(parser, extensions);

    uint64 fileSize = [(NSNumber *)([NSFileManager.defaultManager attributesOfItemAtPath:path error:NULL][NSFileSize]) unsignedLongLongValue];
    NSInputStream *fd = [NSInputStream inputStreamWithFileAtPath:path];
    [fd open];
    uint8_t *buffer = (uint8_t *)malloc(MIN(fileSize, 1024));
    
    while (fd.hasBytesAvailable) {
        NSInteger len = [fd read:buffer maxLength:1024];
        if (len > 0) {
            cmark_parser_feed(parser, (const char *)buffer, len);
        } else {
            break;
        }
    }

    free(buffer);
    [fd close];

    cmark_node *node = cmark_parser_finish(parser);
    cmark_parser_free(parser);

    return node;
}

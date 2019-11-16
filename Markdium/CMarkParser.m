//
//  CMarkParser.m
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "CMarkParser.h"

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

void cmarkEnableGFM(cmark_parser *parser) {
    cmark_parser_attach_syntax_extension(parser, create_tagfilter_extension());
    cmark_parser_attach_syntax_extension(parser, create_autolink_extension());
    cmark_parser_attach_syntax_extension(parser, create_strikethrough_extension());
    cmark_parser_attach_syntax_extension(parser, create_tasklist_extension());
    cmark_parser_attach_syntax_extension(parser, create_table_extension());
}

cmark_node *cmarkParseString(NSString *string, int options, BOOL gfm) {
    if (!string) {
        return NULL;
    }

    cmarkGFMCoreExtensionsEnsureRegistered();

    cmark_parser *parser = cmark_parser_new(options);
    if (!parser) {
        return NULL;
    }

    if (gfm) {
        cmarkEnableGFM(parser);
    }

    const char *utf8String = string.UTF8String;
    cmark_parser_feed(parser, utf8String, strlen(utf8String));
    cmark_node *node = cmark_parser_finish(parser);
    cmark_parser_free(parser);

    return node;
}

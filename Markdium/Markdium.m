//
//  Markdium.swift
//  Markdium
//
//  Created by v on 2019/11/15.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "Markdium.h"

static void cmarkGFMCoreExtensionsEnsureRegistered(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cmark_gfm_core_extensions_ensure_registered();
    });
}

static void cmarkEnableGFM(cmark_parser *parser) {
    cmark_syntax_extension *tagfilter = cmark_find_syntax_extension("tagfilter");
    cmark_parser_attach_syntax_extension(parser, tagfilter);

    cmark_syntax_extension *autolink = cmark_find_syntax_extension("autolink");
    cmark_parser_attach_syntax_extension(parser, autolink);

    cmark_syntax_extension *strikethrough = cmark_find_syntax_extension("strikethrough");
    cmark_parser_attach_syntax_extension(parser, strikethrough);

    cmark_syntax_extension *checkbox = cmark_find_syntax_extension("tasklist");
    cmark_parser_attach_syntax_extension(parser, checkbox);

    cmark_syntax_extension *table = cmark_find_syntax_extension("table");
    cmark_parser_attach_syntax_extension(parser, table);
}

static cmark_node *cmarkParseString(NSString *string, BOOL gfm) {
    if (!string) {
        return NULL;
    }

    cmarkGFMCoreExtensionsEnsureRegistered();

    cmark_parser *parser = cmark_parser_new(CMARK_OPT_DEFAULT);
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

@interface Markdium ()

@property(nonatomic, unsafe_unretained) cmark_node *rootNode;

@end

@implementation Markdium

- (void)dealloc {
    if (_rootNode) {
        cmark_node_free(_rootNode);
    }
}

- (instancetype)initWithString:(NSString *)string enableGFM:(BOOL)gfm {
    cmark_node *node = cmarkParseString(string, gfm);
    if (!node) {
        return nil;
    }

    if (self = [super init]) {
        _rootNode = node;
    }

    return self;
}

@end

@implementation Markdium (render)

- (NSString *)renderAsHTML {
    NSString *output = nil;
    char *html = cmark_render_html(self.rootNode, CMARK_OPT_SAFE, NULL);
    if (html) {
        output = [NSString stringWithUTF8String:html];
        free(html);
    }

    return output;
}

- (NSString *)renderAsXML {
    NSString *output = nil;
    char *xml = cmark_render_xml(self.rootNode, CMARK_OPT_SAFE);
    if (xml) {
        output = [NSString stringWithUTF8String:xml];
        free(xml);
    }

    return output;
}

- (NSString *)renderAsMAN {
    NSString *output = nil;
    char *man = cmark_render_man(self.rootNode, CMARK_OPT_SAFE, self.width);
    if (man) {
        output = [NSString stringWithUTF8String:man];
        free(man);
    }

    return output;
}

- (NSString *)renderAsLatex {
    NSString *output = nil;
    char *latex = cmark_render_latex(self.rootNode, CMARK_OPT_SAFE, self.width);
    if (latex) {
        output = [NSString stringWithUTF8String:latex];
        free(latex);
    }

    return output;
}

- (NSString *)renderAsCommonMark {
    NSString *output = nil;
    char *md = cmark_render_commonmark(self.rootNode, CMARK_OPT_SAFE, self.width);
    if (md) {
        output = [NSString stringWithUTF8String:md];
        free(md);
    }

    return output;
}

- (NSString *)renderAsPlaintext {
    NSString *output = nil;
    char *md = cmark_render_plaintext(self.rootNode, CMARK_OPT_SAFE, self.width);
    if (md) {
        output = [NSString stringWithUTF8String:md];
        free(md);
    }

    return output;
}

@end

@implementation Markdium (version)

+ (NSString *)versionString {
    return [NSString stringWithUTF8String:cmark_version_string()];
}

+ (NSInteger)version {
    return cmark_version();
}

@end

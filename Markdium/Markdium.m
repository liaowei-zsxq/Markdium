//
//  Markdium.swift
//  Markdium
//
//  Created by v on 2019/11/15.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "Markdium.h"
#import "CMarkParser.h"

@interface Markdium ()

@property(nonatomic, assign) NSInteger options;
@property(nonatomic, unsafe_unretained) cmark_node *rootNode;

@end

@implementation Markdium

- (void)dealloc {
    if (_rootNode) {
        cmark_node_free(_rootNode);
    }
}

- (instancetype)initWithString:(NSString *)string {
    return [self initWithString:string options:MDOptionDefault];
}

- (instancetype)initWithString:(NSString *)string options:(MDOptions)options {
    return [self initWithString:string options:options extensions:MDExtensionNone];
}

- (instancetype)initWithString:(NSString *)string options:(MDOptions)options extensions:(MDExtensions)extensions {
    if (!string) {
        return nil;
    }
    
    cmark_node *node = cmarkParseString(string, (int)options, (int)extensions);
    if (!node) {
        return nil;
    }

    if (self = [super init]) {
        _options = options;
        _rootNode = node;
    }

    return self;
}

@end

@implementation Markdium (render)

- (NSString *)renderAsHTML {
    NSString *output = nil;
    char *html = cmark_render_html(self.rootNode, (int)self.options, NULL);
    if (html) {
        output = [NSString stringWithUTF8String:html];
        free(html);
    }

    return output;
}

- (NSString *)renderAsXML {
    NSString *output = nil;
    char *xml = cmark_render_xml(self.rootNode, (int)self.options);
    if (xml) {
        output = [NSString stringWithUTF8String:xml];
        free(xml);
    }

    return output;
}

- (NSString *)renderAsMAN {
    NSString *output = nil;
    char *man = cmark_render_man(self.rootNode, (int)self.options, (int)self.width);
    if (man) {
        output = [NSString stringWithUTF8String:man];
        free(man);
    }

    return output;
}

- (NSString *)renderAsLatex {
    NSString *output = nil;
    char *latex = cmark_render_latex(self.rootNode, (int)self.options, (int)self.width);
    if (latex) {
        output = [NSString stringWithUTF8String:latex];
        free(latex);
    }

    return output;
}

- (NSString *)renderAsCommonMark {
    NSString *output = nil;
    char *md = cmark_render_commonmark(self.rootNode, (int)self.options, (int)self.width);
    if (md) {
        output = [NSString stringWithUTF8String:md];
        free(md);
    }

    return output;
}

- (NSString *)renderAsPlaintext {
    NSString *output = nil;
    char *txt = cmark_render_plaintext(self.rootNode, (int)self.options, (int)self.width);
    if (txt) {
        output = [NSString stringWithUTF8String:txt];
        free(txt);
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

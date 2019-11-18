# Markdium

ObjC wrapper for cmark-gfm, support iOS, macOS, tvOS.

build staticlib with Carthage
```
github "cntrump/Markdium" "master"
```

Build
```
carthage update Markdium
```

## How to use

ObjC
```
@import Markdium;
```

Swift
```
import Markdium
```

```objc
NSString *str = @"[Github](https://github.com \"github\")";
Markdium *md = [[Markdium alloc] initWithString:str options:MDOptionDefault extensions:MDExtensionNone];
```

```objc
[md renderAsHTML];

/** output:
<p><a href="https://github.com" title="github">Github</a></p>
**/
```

```objc
[md renderAsXML];

/** output:
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE document SYSTEM "CommonMark.dtd">
<document xmlns="http://commonmark.org/xml/1.0">
  <paragraph>
    <link destination="https://github.com" title="github">
      <text xml:space="preserve">Github</text>
    </link>
  </paragraph>
</document>
**/
```

```objc
[md renderAsLatex];

/** output:
\href{https://github.com}{Github}
**/
```

```objc
[md renderAsMAN];

/** output:
.PP
Github (https://github.com)
**/
```

```objc
[md renderAsCommonMark];

/** output:
[Github](https://github.com "github")
**/
```

```objc
[md renderAsPlaintext];

/** output:
Github
**/
```

## AST support

```objc
MDNode *document = [md parseAsAST];
```

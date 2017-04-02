//
//  MADefsUI.h
//

#define BUTTON_H 24
#define LABEL_FONT_SZ 15

#define SZ(__s)   NSView ## __s ## Sizable
#define SZ_M(__s) NSView ## __s ## Margin

//---------------------------------------------------------------------------------

#define ADD_BUTTON(__v, __super, __title, __target, __action, __autosz, __x, __y, __w, __h) \
    __v = [[NSButton alloc] initWithFrame:NSMakeRect(__x, __y, __w, __h)]; \
    __v.autoresizingMask = __autosz; \
    __v.bezelStyle = NSRoundedBezelStyle; \
    __v.font = [NSFont systemFontOfSize:13]; \
    __v.title = __title; \
    __v.target = __target; \
    __v.action = __action; \
    [__super addSubview: __v];

#define ADD_LABEL(__v, __super, __font, __fontB, __align, __autosz, __x, __y, __w, __h) \
__v = [[NSTextField alloc] initWithFrame:NSMakeRect(__x, __y, __w, __h)]; \
__v.autoresizingMask = __autosz; \
__v.alignment = __align; \
[__v setBezeled: NO]; \
[__v setDrawsBackground: NO]; \
[__v setEditable:NO]; \
__v.font = (__fontB) ? [NSFont boldSystemFontOfSize:__font] : [NSFont systemFontOfSize:__font]; \
[__super addSubview: __v];

#define ADD_FIELD(__v, __super, __font, __fontB, __autosz, __x, __y, __w, __h) \
__v = [[NSTextField alloc] initWithFrame:NSMakeRect(__x, __y, __w, __h)]; \
__v.autoresizingMask = __autosz; \
__v.font = (__fontB) ? [NSFont boldSystemFontOfSize:__font] : [NSFont systemFontOfSize:__font]; \
[__super addSubview: __v];


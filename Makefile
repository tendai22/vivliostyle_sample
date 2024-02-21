.SUFFIXES: .md _x.md
DEST = .
VPATH = .

TARGET = toc.md $(TOC_TARGET)

TOC_TARGET =intro_x.md \
		preprocessing_x.md \
		cover_x.md \
		tocdesc_x.md \
		box_and_flow_x.md \
		env_x.md \
		footnote_x.md \
		box_layout_x.md \

.md_x.md:
	( sh do_pre.sh $< |sh do_desc.sh - |sh do_item.sh - |sh do_note2.sh -)  > $(DEST)/$@

all: output.pdf

output.pdf: $(TARGET) $(TOC_TARGET) css/sample1.css vivliostyle.config.js
	vivliostyle build -t 1200

toc.md: $(TOC_TARGET)
	sh maketoc0.sh $(TOC_TARGET) > toc.md

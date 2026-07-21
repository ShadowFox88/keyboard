#let report(
  title: "Report Title",
  subtitle: none,
  authors: (),
  date: none,
  abstract: none,
  logo: none,
  accent: rgb("#002147"),
  font: "New Computer Modern",
  mono-font: "DejaVu Sans Mono",
  paper: "a4",
  toc: true,
  body,
) = {
  set document(title: title, author: authors)

  set page(
    paper: paper,
    margin: (top: 3cm, bottom: 2.5cm, x: 2.5cm),
    numbering: "1",
    number-align: bottom + right,
    header: context {
      if here().page() > 1 {
        set text(size: 9pt, fill: rgb("#666666"))
        grid(
          columns: (1fr, 1fr),
          align(left)[#title],
          align(right)[#date],
        )
        line(length: 100%, stroke: 0.5pt + rgb("#cccccc"))
      }
    },
  )

  set text(font: font, size: 11pt, lang: "en")
  set par(justify: true, leading: 0.65em)

  show raw: set text(font: mono-font, size: 9.5pt)
  show raw.where(block: true): block.with(
    fill: rgb("#f5f5f5"),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
  )

  // headings
  set heading(numbering: "1.")

  show heading.where(level: 1): it => {
    set text(size: 20pt, weight: "bold", fill: accent)
    v(1.2em)
    block(it)
    v(0.4em)
  }
  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    v(1em)
    block(it)
    v(0.2em)
  }
  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold", style: "italic")
    v(0.8em)
    block(it)
  }

  // links
  show link: it => text(fill: accent, it)

  // figures
  show figure.caption: set text(size: 9.5pt, style: "italic")
  set figure(gap: 0.8em)

  // tables
  set table(
    stroke: 0.6pt + rgb("#cccccc"),
    inset: 6pt,
  )

  // title
  align(center)[
    #v(2cm)
    #if logo != none {
      logo
      v(1cm)
    }
    #text(size: 28pt, weight: "bold", fill: accent)[#title]
    #v(0.4cm)
    #if subtitle != none {
      text(size: 16pt, style: "italic", fill: rgb("#555555"))[#subtitle]
    }
    #v(1.5cm)
    #if authors.len() > 0 {
      text(size: 12pt)[
        #authors.map(a => a).join(" · ")
      ]
    }
    #v(0.3cm)
    #if date != none {
      text(size: 11pt, fill: rgb("#666666"))[#date]
    }
  ]

  v(1fr)

  if abstract != none {
    align(center)[
      #block(
        width: 85%,
        inset: 12pt,
        radius: 4pt,
        fill: rgb("#f5f7fa"),
        stroke: 0.6pt + rgb("#dde3ea"),
      )[
        #text(weight: "bold", size: 10.5pt)[Abstract] \
        #set text(size: 10pt)
        #abstract
      ]
    ]
  }

  v(1fr)
  pagebreak()

  // contents
  if toc {
    outline(title: "Contents", indent: auto)
    pagebreak()
  }

  body
}

#let note(body, title: "Note", color: rgb("#002147")) = block(
  width: 100%,
  inset: 10pt,
  radius: 4pt,
  fill: color.lighten(92%),
  stroke: (left: 3pt + color),
)[
  #text(weight: "bold", fill: color)[#title] \
  #body
]


#let warning(body) = note(body, title: "Warning", color: rgb("#DC2626"))

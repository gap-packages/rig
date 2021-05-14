SetPackageInfo( rec(
PackageName := "rig",
Subtitle := "Racks in GAP",
Version := "1",
Date := "24/05/2014", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec( 
    LastName      := "Vendramin",
    FirstNames    := "Leandro",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "lvendramin@dm.uba.ar",
    WWWHome       := "http://mate.dm.uba.ar/~lvendram",
    PostalAddress := Concatenation( [
                       "Departamento de matemática, FCEyN, UBA",
                       "Ciudad Universitaria, Pab. 1,\n",
                       "Buenos Aires, Argentina" ] ),
    Place         := "Buenos Aires",
    Institution   := "UBA"
  )
],

Status := "deposited",

PackageWWWHome  := "https://gap-packages.github.io/rig/",
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/gap-packages/rig",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/rig-", ~.Version ),
ArchiveFormats := ".tar.gz",

AbstractHTML := 
  "The <span class=\"pkgname\">Example</span> package, as its name suggests, \
   is an example of how to create a <span class=\"pkgname\">GAP</span> \
   package. It has little functionality except for being a package",

PackageDoc := rec(
  BookName  := "rig",
  ArchiveURLSubset := ["doc", "htm"],
  HTMLStart := "htm/chapters.htm",
  PDFFile   := "doc/manual.pdf",
  # the path to the .six file used by GAP's help system
  SixFile   := "doc/manual.six",
  # a longer title of the book, this together with the book name should
  # fit on a single text line (appears with the '?books' command in GAP)
  LongTitle := "A GAP package for racks, quandles and crossed sets",
  # Should this help book be autoloaded when GAP starts up? This should
  # usually be 'true', otherwise say 'false'. 
  Autoload  := true
),

Dependencies := rec(
  GAP := ">=4.8",
  NeededOtherPackages := [],
  SuggestedOtherPackages := [],
  ExternalConditions := []
),

AvailabilityTest := ReturnTrue,
TestFile := "tst/testall.g",
Keywords := ["racks", "quandles", "nichols algebras", "knots"]
));



Bitmap Editor
=================================

Prints out a bitmap with M columns and N rows.
Command to create bitmap : I M N

Run
=================================
$ruby lib/run.rb

> I 5 6
> S
OOOOO
OOOOO
OOOOO
OOOOO
OOOOO
OOOOO

> L 2 3 A
> S
OOOOO
OOOOO
OAOOO
OOOOO
OOOOO
OOOOO
> V 2 3 6 W
> H 3 5 2 Z
> S
OOOOO
OOZZZ
OWOOO
OWOOO
OWOOO
OWOOO

Run Spec
=================================
$bundle exec rspec -f d


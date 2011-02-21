
#############################################################################
##
##  Data
##

SMALL_I_QUANDLES := [ ];
SMALL_I_QUANDLES_C := [ ];



## New possible size: 1
SMALL_I_QUANDLES[1] := rec( total := -1, implemented := 1, size := 1, rack := [ ] );


## A rack of size   1, exponents         , combinatorics k2 =    0,   k3 =    0,   m =    0,   n =    0
SMALL_I_QUANDLES[1].implemented := 1;
SMALL_I_QUANDLES[1].rack[1] := rec( size := 1, matrix :=
  [[1]], 
);

## size 3 
SMALL_I_QUANDLES[3] := rec( total := -1, implemented := 1, size := 3, rack := [ ] );
SMALL_I_QUANDLES[3].implemented := 1;
SMALL_I_QUANDLES[3].rack[1] := rec( size := 3, matrix :=
  [[1, 3, 2],  
   [3, 2, 1], 
   [2, 1, 3]],
);

## size 4
SMALL_I_QUANDLES[4] := rec( total := -1, implemented := 1, size := 4, rack := [ ] );
SMALL_I_QUANDLES[4].implemented := 1;
SMALL_I_QUANDLES[4].rack[1] := rec( size := 4, matrix :=
  [[ 1, 3, 4, 2 ], 
   [ 4, 2, 1, 3 ], 
   [ 2, 4, 3, 1 ], 
   [ 3, 1, 2, 4 ]],
);

## size 5
SMALL_I_QUANDLES[5] := rec( total := -1, implemented := 3, size := 5, rack := [ ] );
SMALL_I_QUANDLES[5].implemented := 1;
SMALL_I_QUANDLES[5].rack[1] := rec( size := 5, matrix :=
[ [ 1, 5, 4, 3, 2 ], 
  [ 3, 2, 1, 5, 4 ], 
  [ 5, 4, 3, 2, 1 ], 
  [ 2, 1, 5, 4, 3 ], 
  [ 4, 3, 2, 1, 5 ] 
]);

SMALL_I_QUANDLES[5].implemented := 2;
SMALL_I_QUANDLES[5].rack[3] := rec( size := 5, matrix :=
[ [ 1, 3, 5, 2, 4 ], 
  [ 5, 2, 4, 1, 3 ], 
  [ 4, 1, 3, 5, 2 ], 
  [ 3, 5, 2, 4, 1 ], 
  [ 2, 4, 1, 3, 5 ] 
]);

SMALL_I_QUANDLES[5].implemented := 3;
SMALL_I_QUANDLES[5].rack[2] := rec( size := 5, matrix :=
[ [ 1, 4, 2, 5, 3 ], 
  [ 4, 2, 5, 3, 1 ], 
  [ 2, 5, 3, 1, 4 ], 
  [ 5, 3, 1, 4, 2 ], 
  [ 3, 1, 4, 2, 5 ] 
]);

## size 6
SMALL_I_QUANDLES[6] := rec( total := -1, implemented := 2, size := 6, rack := [ ] );
SMALL_I_QUANDLES[6].implemented := 1;
SMALL_I_QUANDLES[6].rack[1] := rec( size := 6, matrix :=
[ [ 1, 2, 5, 6, 3, 4 ], 
  [ 1, 2, 6, 5, 4, 3 ], 
  [ 5, 6, 3, 4, 1, 2 ], 
  [ 6, 5, 3, 4, 2, 1 ], 
  [ 3, 4, 1, 2, 5, 6 ], 
  [ 4, 3, 2, 1, 5, 6 ] 
]);

SMALL_I_QUANDLES[6].implemented := 2;
SMALL_I_QUANDLES[6].rack[2] := rec( size := 6, matrix :=
[ [ 1, 2, 5, 6, 4, 3 ], 
  [ 1, 2, 6, 5, 3, 4 ], 
  [ 6, 5, 3, 4, 1, 2 ], 
  [ 5, 6, 3, 4, 2, 1 ], 
  [ 3, 4, 2, 1, 5, 6 ], 
  [ 4, 3, 1, 2, 5, 6 ] 
]);

## size 7
SMALL_I_QUANDLES[7] := rec( total := -1, implemented := 5, size := 7, rack := [ ] );
SMALL_I_QUANDLES[7].implemented := 1;
SMALL_I_QUANDLES[7].rack[1] := rec( size := 7, matrix :=
[ [ 1, 7, 6, 5, 4, 3, 2 ], [ 3, 2, 1, 7, 6, 5, 4 ], [ 5, 4, 3, 2, 1, 7, 6 ], [ 7, 6, 5, 4, 3, 2, 1 ], 
  [ 2, 1, 7, 6, 5, 4, 3 ], [ 4, 3, 2, 1, 7, 6, 5 ], [ 6, 5, 4, 3, 2, 1, 7 ] ]);
SMALL_I_QUANDLES[7].implemented := 2;
SMALL_I_QUANDLES[7].rack[2] := rec( size := 7, matrix :=
[ [ 1, 5, 2, 6, 3, 7, 4 ], [ 5, 2, 6, 3, 7, 4, 1 ], [ 2, 6, 3, 7, 4, 1, 5 ], [ 6, 3, 7, 4, 1, 5, 2 ], 
  [ 3, 7, 4, 1, 5, 2, 6 ], [ 7, 4, 1, 5, 2, 6, 3 ], [ 4, 1, 5, 2, 6, 3, 7 ] ]);
SMALL_I_QUANDLES[7].implemented := 3;
SMALL_I_QUANDLES[7].rack[3] := rec( size := 7, matrix :=
[ [ 1, 3, 5, 7, 2, 4, 6 ], [ 7, 2, 4, 6, 1, 3, 5 ], [ 6, 1, 3, 5, 7, 2, 4 ], [ 5, 7, 2, 4, 6, 1, 3 ], 
  [ 4, 6, 1, 3, 5, 7, 2 ], [ 3, 5, 7, 2, 4, 6, 1 ], [ 2, 4, 6, 1, 3, 5, 7 ] ]);
SMALL_I_QUANDLES[7].implemented := 4;
SMALL_I_QUANDLES[7].rack[4] := rec( size := 7, matrix :=
[ [ 1, 6, 4, 2, 7, 5, 3 ], [ 4, 2, 7, 5, 3, 1, 6 ], [ 7, 5, 3, 1, 6, 4, 2 ], [ 3, 1, 6, 4, 2, 7, 5 ], 
  [ 6, 4, 2, 7, 5, 3, 1 ], [ 2, 7, 5, 3, 1, 6, 4 ], [ 5, 3, 1, 6, 4, 2, 7 ] ]);
SMALL_I_QUANDLES[7].implemented := 5;
SMALL_I_QUANDLES[7].rack[5] := rec( size := 7, matrix :=
[ [ 1, 4, 7, 3, 6, 2, 5 ], [ 6, 2, 5, 1, 4, 7, 3 ], [ 4, 7, 3, 6, 2, 5, 1 ], [ 2, 5, 1, 4, 7, 3, 6 ], 
  [ 7, 3, 6, 2, 5, 1, 4 ], [ 5, 1, 4, 7, 3, 6, 2 ], [ 3, 6, 2, 5, 1, 4, 7 ] ]);


## size 8
SMALL_I_QUANDLES[8] := rec( total := -1, implemented := 3, size := 8, rack := [ ] );
SMALL_I_QUANDLES[8].implemented := 1;
SMALL_I_QUANDLES[8].rack[1] := rec( size := 8, matrix :=
[ [ 1, 2, 7, 8, 4, 3, 6, 5 ], [ 1, 2, 7, 8, 4, 3, 6, 5 ], [ 6, 5, 3, 4, 7, 8, 2, 1 ], [ 6, 5, 3, 4, 7, 8, 2, 1 ], 
  [ 7, 8, 2, 1, 5, 6, 4, 3 ], [ 7, 8, 2, 1, 5, 6, 4, 3 ], [ 3, 4, 5, 6, 1, 2, 7, 8 ], [ 3, 4, 5, 6, 1, 2, 7, 8 ] ]);
SMALL_I_QUANDLES[8].implemented := 2;
SMALL_I_QUANDLES[8].rack[2] := rec( size := 8, matrix :=
[ [ 1, 6, 2, 5, 3, 8, 4, 7 ], [ 5, 2, 6, 1, 7, 4, 8, 3 ], [ 4, 7, 3, 8, 2, 5, 1, 6 ], [ 8, 3, 7, 4, 6, 1, 5, 2 ], 
  [ 7, 4, 8, 3, 5, 2, 6, 1 ], [ 3, 8, 4, 7, 1, 6, 2, 5 ], [ 6, 1, 5, 2, 8, 3, 7, 4 ], [ 2, 5, 1, 6, 4, 7, 3, 8 ] ]);
SMALL_I_QUANDLES[8].implemented := 3;
SMALL_I_QUANDLES[8].rack[3] := rec( size := 8, matrix :=
[ [ 1, 7, 8, 2, 6, 4, 3, 5 ], [ 8, 2, 1, 7, 3, 5, 6, 4 ], [ 6, 4, 3, 5, 1, 7, 8, 2 ], [ 3, 5, 6, 4, 8, 2, 1, 7 ], 
  [ 2, 8, 7, 1, 5, 3, 4, 6 ], [ 7, 1, 2, 8, 4, 6, 5, 3 ], [ 5, 3, 4, 6, 2, 8, 7, 1 ], [ 4, 6, 5, 3, 7, 1, 2, 8 ] ]);

## size 9
SMALL_I_QUANDLES[9] := rec( total := -1, implemented := 8, size := 9, rack := [ ] );
SMALL_I_QUANDLES[9].implemented := 1;
SMALL_I_QUANDLES[9].rack[1] := rec( size := 9, matrix :=
[ [ 1, 3, 2, 9, 8, 7, 6, 5, 4 ], [ 3, 2, 1, 8, 7, 9, 5, 4, 6 ], [ 2, 1, 3, 7, 9, 8, 4, 6, 5 ], 
  [ 7, 9, 8, 4, 6, 5, 1, 3, 2 ], [ 9, 8, 7, 6, 5, 4, 3, 2, 1 ], [ 8, 7, 9, 5, 4, 6, 2, 1, 3 ], 
  [ 5, 4, 6, 2, 1, 3, 7, 9, 8 ], [ 4, 6, 5, 1, 3, 2, 9, 8, 7 ], [ 6, 5, 4, 3, 2, 1, 8, 7, 9 ] ]);
SMALL_I_QUANDLES[9].implemented := 2;
SMALL_I_QUANDLES[9].rack[2] := rec( size := 9, matrix :=
[ [ 1, 3, 2, 7, 9, 8, 4, 6, 5 ], [ 3, 2, 1, 9, 8, 7, 6, 5, 4 ], [ 2, 1, 3, 8, 7, 9, 5, 4, 6 ], 
  [ 7, 9, 8, 4, 6, 5, 1, 3, 2 ], [ 9, 8, 7, 6, 5, 4, 3, 2, 1 ], [ 8, 7, 9, 5, 4, 6, 2, 1, 3 ], 
  [ 4, 6, 5, 1, 3, 2, 7, 9, 8 ], [ 6, 5, 4, 3, 2, 1, 9, 8, 7 ], [ 5, 4, 6, 2, 1, 3, 8, 7, 9 ] ]);
SMALL_I_QUANDLES[9].implemented := 3;
SMALL_I_QUANDLES[9].rack[3] := rec( size := 9, matrix :=
[ [ 1, 7, 4, 2, 8, 5, 3, 9, 6 ], [ 5, 2, 8, 6, 3, 9, 4, 1, 7 ], [ 9, 6, 3, 7, 4, 1, 8, 5, 2 ], 
  [ 6, 3, 9, 4, 1, 7, 5, 2, 8 ], [ 7, 4, 1, 8, 5, 2, 9, 6, 3 ], [ 2, 8, 5, 3, 9, 6, 1, 7, 4 ], 
  [ 8, 5, 2, 9, 6, 3, 7, 4, 1 ], [ 3, 9, 6, 1, 7, 4, 2, 8, 5 ], [ 4, 1, 7, 5, 2, 8, 6, 3, 9 ] ]);
SMALL_I_QUANDLES[9].implemented := 4;
SMALL_I_QUANDLES[9].rack[4] := rec( size := 9, matrix :=
[ [ 1, 3, 2, 7, 9, 8, 5, 4, 6 ], [ 3, 2, 1, 9, 8, 7, 4, 6, 5 ], [ 2, 1, 3, 8, 7, 9, 6, 5, 4 ], 
  [ 9, 8, 7, 4, 6, 5, 2, 1, 3 ], [ 8, 7, 9, 6, 5, 4, 1, 3, 2 ], [ 7, 9, 8, 5, 4, 6, 3, 2, 1 ], 
  [ 6, 5, 4, 1, 3, 2, 7, 9, 8 ], [ 5, 4, 6, 3, 2, 1, 9, 8, 7 ], [ 4, 6, 5, 2, 1, 3, 8, 7, 9 ] ]);
SMALL_I_QUANDLES[9].implemented := 5;
SMALL_I_QUANDLES[9].rack[5] := rec( size := 9, matrix :=
[ [ 1, 3, 2, 8, 7, 9, 4, 6, 5 ], [ 3, 2, 1, 7, 9, 8, 6, 5, 4 ], [ 2, 1, 3, 9, 8, 7, 5, 4, 6 ], 
  [ 8, 7, 9, 4, 6, 5, 3, 2, 1 ], [ 7, 9, 8, 6, 5, 4, 2, 1, 3 ], [ 9, 8, 7, 5, 4, 6, 1, 3, 2 ], 
  [ 4, 6, 5, 3, 2, 1, 7, 9, 8 ], [ 6, 5, 4, 2, 1, 3, 9, 8, 7 ], [ 5, 4, 6, 1, 3, 2, 8, 7, 9 ] ]);
SMALL_I_QUANDLES[9].implemented := 6;
SMALL_I_QUANDLES[9].rack[6] := rec( size := 9, matrix :=
[ [ 1, 3, 2, 8, 7, 9, 6, 5, 4 ], [ 3, 2, 1, 7, 9, 8, 5, 4, 6 ], [ 2, 1, 3, 9, 8, 7, 4, 6, 5 ], 
  [ 9, 8, 7, 4, 6, 5, 2, 1, 3 ], [ 8, 7, 9, 6, 5, 4, 1, 3, 2 ], [ 7, 9, 8, 5, 4, 6, 3, 2, 1 ], 
  [ 5, 4, 6, 3, 2, 1, 7, 9, 8 ], [ 4, 6, 5, 2, 1, 3, 9, 8, 7 ], [ 6, 5, 4, 1, 3, 2, 8, 7, 9 ] ]);
SMALL_I_QUANDLES[9].implemented := 7;
SMALL_I_QUANDLES[9].rack[7] := rec( size := 9, matrix :=
[ [ 1, 5, 9, 2, 6, 7, 3, 4, 8 ], [ 7, 2, 6, 8, 3, 4, 9, 1, 5 ], [ 4, 8, 3, 5, 9, 1, 6, 7, 2 ], 
  [ 6, 7, 2, 4, 8, 3, 5, 9, 1 ], [ 3, 4, 8, 1, 5, 9, 2, 6, 7 ], [ 9, 1, 5, 7, 2, 6, 8, 3, 4 ], 
  [ 8, 3, 4, 9, 1, 5, 7, 2, 6 ], [ 5, 9, 1, 6, 7, 2, 4, 8, 3 ], [ 2, 6, 7, 3, 4, 8, 1, 5, 9 ] ]);
SMALL_I_QUANDLES[9].implemented := 8;
SMALL_I_QUANDLES[9].rack[8] := rec( size := 9, matrix :=
[ [ 1, 9, 5, 3, 8, 4, 2, 7, 6 ], [ 6, 2, 7, 5, 1, 9, 4, 3, 8 ], [ 8, 4, 3, 7, 6, 2, 9, 5, 1 ], 
  [ 5, 1, 9, 4, 3, 8, 6, 2, 7 ], [ 7, 6, 2, 9, 5, 1, 8, 4, 3 ], [ 3, 8, 4, 2, 7, 6, 1, 9, 5 ], 
  [ 9, 5, 1, 8, 4, 3, 7, 6, 2 ], [ 2, 7, 6, 1, 9, 5, 3, 8, 4 ], [ 4, 3, 8, 6, 2, 7, 5, 1, 9 ] ]);

## size 10
SMALL_I_QUANDLES[10] := rec( total := -1, implemented := 1, size := 10, rack := [ ] );
SMALL_I_QUANDLES[10].implemented := 1;
SMALL_I_QUANDLES[10].rack[1] := rec( size := 10, matrix :=
[ [ 1, 7, 5, 6, 3, 4, 2, 8, 9, 10 ], [ 7, 2, 8, 10, 5, 6, 1, 3, 9, 4 ], [ 5, 8, 3, 9, 1, 6, 7, 2, 4, 10 ], 
  [ 6, 10, 9, 4, 5, 1, 7, 8, 3, 2 ], [ 3, 2, 1, 4, 5, 9, 8, 7, 6, 10 ], [ 4, 2, 3, 1, 9, 6, 10, 8, 5, 7 ], 
  [ 2, 1, 3, 4, 8, 10, 7, 5, 9, 6 ], [ 1, 3, 2, 4, 7, 6, 5, 8, 10, 9 ], [ 1, 2, 4, 3, 6, 5, 7, 10, 9, 8 ], 
  [ 1, 4, 3, 2, 5, 7, 6, 9, 8, 10 ] ]);

## size 11
SMALL_I_QUANDLES[11] := rec( total := -1, implemented := 9, size := 11, rack := [ ] );
SMALL_I_QUANDLES[11].implemented := 1;
SMALL_I_QUANDLES[11].rack[1] := rec( size := 11, matrix :=
[ [ 1, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 ], [ 3, 2, 1, 11, 10, 9, 8, 7, 6, 5, 4 ], [ 5, 4, 3, 2, 1, 11, 10, 9, 8, 7, 6 ], 
  [ 7, 6, 5, 4, 3, 2, 1, 11, 10, 9, 8 ], [ 9, 8, 7, 6, 5, 4, 3, 2, 1, 11, 10 ], [ 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 ], 
  [ 2, 1, 11, 10, 9, 8, 7, 6, 5, 4, 3 ], [ 4, 3, 2, 1, 11, 10, 9, 8, 7, 6, 5 ], [ 6, 5, 4, 3, 2, 1, 11, 10, 9, 8, 7 ], 
  [ 8, 7, 6, 5, 4, 3, 2, 1, 11, 10, 9 ], [ 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 11 ] ]);
SMALL_I_QUANDLES[11].implemented := 2;
SMALL_I_QUANDLES[11].rack[2] := rec( size := 11, matrix :=
[ [ 1, 5, 9, 2, 6, 10, 3, 7, 11, 4, 8 ], [ 9, 2, 6, 10, 3, 7, 11, 4, 8, 1, 5 ], [ 6, 10, 3, 7, 11, 4, 8, 1, 5, 9, 2 ], 
  [ 3, 7, 11, 4, 8, 1, 5, 9, 2, 6, 10 ], [ 11, 4, 8, 1, 5, 9, 2, 6, 10, 3, 7 ], [ 8, 1, 5, 9, 2, 6, 10, 3, 7, 11, 4 ], 
  [ 5, 9, 2, 6, 10, 3, 7, 11, 4, 8, 1 ], [ 2, 6, 10, 3, 7, 11, 4, 8, 1, 5, 9 ], [ 10, 3, 7, 11, 4, 8, 1, 5, 9, 2, 6 ], 
  [ 7, 11, 4, 8, 1, 5, 9, 2, 6, 10, 3 ], [ 4, 8, 1, 5, 9, 2, 6, 10, 3, 7, 11 ] ]);
SMALL_I_QUANDLES[11].implemented := 3;
SMALL_I_QUANDLES[11].rack[3] := rec( size := 11, matrix :=
[ [ 1, 6, 11, 5, 10, 4, 9, 3, 8, 2, 7 ], [ 8, 2, 7, 1, 6, 11, 5, 10, 4, 9, 3 ], [ 4, 9, 3, 8, 2, 7, 1, 6, 11, 5, 10 ], 
  [ 11, 5, 10, 4, 9, 3, 8, 2, 7, 1, 6 ], [ 7, 1, 6, 11, 5, 10, 4, 9, 3, 8, 2 ], [ 3, 8, 2, 7, 1, 6, 11, 5, 10, 4, 9 ], 
  [ 10, 4, 9, 3, 8, 2, 7, 1, 6, 11, 5 ], [ 6, 11, 5, 10, 4, 9, 3, 8, 2, 7, 1 ], [ 2, 7, 1, 6, 11, 5, 10, 4, 9, 3, 8 ], 
  [ 9, 3, 8, 2, 7, 1, 6, 11, 5, 10, 4 ], [ 5, 10, 4, 9, 3, 8, 2, 7, 1, 6, 11 ] ]);
SMALL_I_QUANDLES[11].implemented := 4;
SMALL_I_QUANDLES[11].rack[4] := rec( size := 11, matrix :=
[ [ 1, 10, 8, 6, 4, 2, 11, 9, 7, 5, 3 ], [ 4, 2, 11, 9, 7, 5, 3, 1, 10, 8, 6 ], [ 7, 5, 3, 1, 10, 8, 6, 4, 2, 11, 9 ], 
  [ 10, 8, 6, 4, 2, 11, 9, 7, 5, 3, 1 ], [ 2, 11, 9, 7, 5, 3, 1, 10, 8, 6, 4 ], [ 5, 3, 1, 10, 8, 6, 4, 2, 11, 9, 7 ], 
  [ 8, 6, 4, 2, 11, 9, 7, 5, 3, 1, 10 ], [ 11, 9, 7, 5, 3, 1, 10, 8, 6, 4, 2 ], [ 3, 1, 10, 8, 6, 4, 2, 11, 9, 7, 5 ], 
  [ 6, 4, 2, 11, 9, 7, 5, 3, 1, 10, 8 ], [ 9, 7, 5, 3, 1, 10, 8, 6, 4, 2, 11 ] ]);
SMALL_I_QUANDLES[11].implemented := 5;
SMALL_I_QUANDLES[11].rack[5] := rec( size := 11, matrix :=
[ [ 1, 4, 7, 10, 2, 5, 8, 11, 3, 6, 9 ], [ 10, 2, 5, 8, 11, 3, 6, 9, 1, 4, 7 ], [ 8, 11, 3, 6, 9, 1, 4, 7, 10, 2, 5 ], 
  [ 6, 9, 1, 4, 7, 10, 2, 5, 8, 11, 3 ], [ 4, 7, 10, 2, 5, 8, 11, 3, 6, 9, 1 ], [ 2, 5, 8, 11, 3, 6, 9, 1, 4, 7, 10 ], 
  [ 11, 3, 6, 9, 1, 4, 7, 10, 2, 5, 8 ], [ 9, 1, 4, 7, 10, 2, 5, 8, 11, 3, 6 ], [ 7, 10, 2, 5, 8, 11, 3, 6, 9, 1, 4 ], 
  [ 5, 8, 11, 3, 6, 9, 1, 4, 7, 10, 2 ], [ 3, 6, 9, 1, 4, 7, 10, 2, 5, 8, 11 ] ]);
SMALL_I_QUANDLES[11].implemented := 6;
SMALL_I_QUANDLES[11].rack[6] := rec( size := 11, matrix :=
[ [ 1, 7, 2, 8, 3, 9, 4, 10, 5, 11, 6 ], [ 7, 2, 8, 3, 9, 4, 10, 5, 11, 6, 1 ], [ 2, 8, 3, 9, 4, 10, 5, 11, 6, 1, 7 ], 
  [ 8, 3, 9, 4, 10, 5, 11, 6, 1, 7, 2 ], [ 3, 9, 4, 10, 5, 11, 6, 1, 7, 2, 8 ], [ 9, 4, 10, 5, 11, 6, 1, 7, 2, 8, 3 ], 
  [ 4, 10, 5, 11, 6, 1, 7, 2, 8, 3, 9 ], [ 10, 5, 11, 6, 1, 7, 2, 8, 3, 9, 4 ], [ 5, 11, 6, 1, 7, 2, 8, 3, 9, 4, 10 ], 
  [ 11, 6, 1, 7, 2, 8, 3, 9, 4, 10, 5 ], [ 6, 1, 7, 2, 8, 3, 9, 4, 10, 5, 11 ] ]);
SMALL_I_QUANDLES[11].implemented := 7;
SMALL_I_QUANDLES[11].rack[7] := rec( size := 11, matrix :=
[ [ 1, 8, 4, 11, 7, 3, 10, 6, 2, 9, 5 ], [ 6, 2, 9, 5, 1, 8, 4, 11, 7, 3, 10 ], [ 11, 7, 3, 10, 6, 2, 9, 5, 1, 8, 4 ], 
  [ 5, 1, 8, 4, 11, 7, 3, 10, 6, 2, 9 ], [ 10, 6, 2, 9, 5, 1, 8, 4, 11, 7, 3 ], [ 4, 11, 7, 3, 10, 6, 2, 9, 5, 1, 8 ], 
  [ 9, 5, 1, 8, 4, 11, 7, 3, 10, 6, 2 ], [ 3, 10, 6, 2, 9, 5, 1, 8, 4, 11, 7 ], [ 8, 4, 11, 7, 3, 10, 6, 2, 9, 5, 1 ], 
  [ 2, 9, 5, 1, 8, 4, 11, 7, 3, 10, 6 ], [ 7, 3, 10, 6, 2, 9, 5, 1, 8, 4, 11 ] ]);
SMALL_I_QUANDLES[11].implemented := 8;
SMALL_I_QUANDLES[11].rack[8] := rec( size := 11, matrix :=
[ [ 1, 9, 6, 3, 11, 8, 5, 2, 10, 7, 4 ], [ 5, 2, 10, 7, 4, 1, 9, 6, 3, 11, 8 ], [ 9, 6, 3, 11, 8, 5, 2, 10, 7, 4, 1 ], 
  [ 2, 10, 7, 4, 1, 9, 6, 3, 11, 8, 5 ], [ 6, 3, 11, 8, 5, 2, 10, 7, 4, 1, 9 ], [ 10, 7, 4, 1, 9, 6, 3, 11, 8, 5, 2 ], 
  [ 3, 11, 8, 5, 2, 10, 7, 4, 1, 9, 6 ], [ 7, 4, 1, 9, 6, 3, 11, 8, 5, 2, 10 ], [ 11, 8, 5, 2, 10, 7, 4, 1, 9, 6, 3 ], 
  [ 4, 1, 9, 6, 3, 11, 8, 5, 2, 10, 7 ], [ 8, 5, 2, 10, 7, 4, 1, 9, 6, 3, 11 ] ]);
SMALL_I_QUANDLES[11].implemented := 9;
SMALL_I_QUANDLES[11].rack[9] := rec( size := 11, matrix :=
[ [ 1, 3, 5, 7, 9, 11, 2, 4, 6, 8, 10 ], [ 11, 2, 4, 6, 8, 10, 1, 3, 5, 7, 9 ], [ 10, 1, 3, 5, 7, 9, 11, 2, 4, 6, 8 ], 
  [ 9, 11, 2, 4, 6, 8, 10, 1, 3, 5, 7 ], [ 8, 10, 1, 3, 5, 7, 9, 11, 2, 4, 6 ], [ 7, 9, 11, 2, 4, 6, 8, 10, 1, 3, 5 ], 
  [ 6, 8, 10, 1, 3, 5, 7, 9, 11, 2, 4 ], [ 5, 7, 9, 11, 2, 4, 6, 8, 10, 1, 3 ], [ 4, 6, 8, 10, 1, 3, 5, 7, 9, 11, 2 ], 
  [ 3, 5, 7, 9, 11, 2, 4, 6, 8, 10, 1 ], [ 2, 4, 6, 8, 10, 1, 3, 5, 7, 9, 11 ] ]);


#############################################################################
##
##  Functions
##

InstallGlobalFunction("NrSmallIndecomposableQuandlesImplemented",
  function(size)
  local known_in_a, known_in_c, implemented_in_a, implemented_in_c;
  known_in_a := IsBound(SMALL_I_QUANDLES[size]);
  known_in_c := IsBound(SMALL_I_QUANDLES_C[size]);
  implemented_in_a := 0;
  if known_in_a then
    implemented_in_a := SMALL_I_QUANDLES[size].implemented;
  fi;
  implemented_in_c := 0;
  if known_in_c then
    implemented_in_c := SMALL_I_QUANDLES_C[size].implemented;
  fi;
  return implemented_in_a + implemented_in_c;
end);

InstallGlobalFunction("SmallIndecomposableQuandle",
  function(size, number)
  local known_in_a, known_in_c, implemented_in_a;
  known_in_a := IsBound(SMALL_I_QUANDLES[size]);
  known_in_c := IsBound(SMALL_I_QUANDLES_C[size]);
  if (not known_in_a) and (not known_in_c) then
    Error("There are no racks known of size ", size, " to this library.");
  fi;
  implemented_in_a := 0;
  if known_in_a then
    implemented_in_a := SMALL_I_QUANDLES[size].implemented;
  fi;
  if number <= implemented_in_a then
    if not IsBound(SMALL_I_QUANDLES[size].rack[number]) then
      Error("There is no rack known of size ", size, " and number ", number, " to this library.");
    fi;
    return Rack(SMALL_I_QUANDLES[size].rack[number].matrix);
  else
    if not IsBound(SMALL_I_QUANDLES_C[size].rack[number - implemented_in_a]) then
      Error("There is no rack known of size ", size, " and number ", number, " to this library.");
    fi;
    return Rack(SMALL_I_QUANDLES_C[size].rack[number - implemented_in_a].matrix);
  fi;
end);

InstallGlobalFunction("SmallIndecomposableQuandlesInformation",
  function(size)
    return Concatenation(
      "Size ", String(size), ": ", String(NrSmallIndecomposableQuandlesImplemented(size)), " rack(s) known. ");
end);

InstallGlobalFunction("SmallIndecomposableQuandleSizesImplemented",
  function()
  local l, j;
  l := [ ];
  for j in [1..360] do
    if NrSmallIndecomposableQuandlesImplemented(j) > 0 then
      Add(l, j);
    fi;
  od;
  return l;
end);





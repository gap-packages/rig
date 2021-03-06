## size 18
QUANDLES[18] := rec( total := -1, implemented := 12, size := 18, rack := [ ] );
QUANDLES[18].implemented := 1;
QUANDLES[18].rack[1] := rec( size := 18, matrix :=
[ [ 1, 2, 5, 6, 3, 4, 13, 14, 17, 18, 15, 16, 7, 8, 11, 12, 9, 10 ], 
  [ 1, 2, 5, 6, 3, 4, 14, 13, 18, 17, 16, 15, 8, 7, 12, 11, 10, 9 ], 
  [ 5, 6, 3, 4, 1, 2, 17, 18, 15, 16, 13, 14, 11, 12, 9, 10, 7, 8 ], 
  [ 5, 6, 3, 4, 1, 2, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7 ], 
  [ 3, 4, 1, 2, 5, 6, 15, 16, 13, 14, 17, 18, 9, 10, 7, 8, 11, 12 ], 
  [ 3, 4, 1, 2, 5, 6, 16, 15, 14, 13, 18, 17, 10, 9, 8, 7, 12, 11 ], 
  [ 13, 14, 17, 18, 15, 16, 7, 8, 11, 12, 9, 10, 1, 2, 5, 6, 3, 4 ], 
  [ 14, 13, 18, 17, 16, 15, 7, 8, 11, 12, 9, 10, 2, 1, 6, 5, 4, 3 ], 
  [ 17, 18, 15, 16, 13, 14, 11, 12, 9, 10, 7, 8, 5, 6, 3, 4, 1, 2 ], 
  [ 18, 17, 16, 15, 14, 13, 11, 12, 9, 10, 7, 8, 6, 5, 4, 3, 2, 1 ], 
  [ 15, 16, 13, 14, 17, 18, 9, 10, 7, 8, 11, 12, 3, 4, 1, 2, 5, 6 ], 
  [ 16, 15, 14, 13, 18, 17, 9, 10, 7, 8, 11, 12, 4, 3, 2, 1, 6, 5 ], 
  [ 7, 8, 11, 12, 9, 10, 1, 2, 5, 6, 3, 4, 13, 14, 17, 18, 15, 16 ], 
  [ 8, 7, 12, 11, 10, 9, 2, 1, 6, 5, 4, 3, 13, 14, 17, 18, 15, 16 ], 
  [ 11, 12, 9, 10, 7, 8, 5, 6, 3, 4, 1, 2, 17, 18, 15, 16, 13, 14 ], 
  [ 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 17, 18, 15, 16, 13, 14 ], 
  [ 9, 10, 7, 8, 11, 12, 3, 4, 1, 2, 5, 6, 15, 16, 13, 14, 17, 18 ], 
  [ 10, 9, 8, 7, 12, 11, 4, 3, 2, 1, 6, 5, 15, 16, 13, 14, 17, 18 ] ]);
QUANDLES[18].implemented := 2;
QUANDLES[18].rack[2] := rec( size := 18, matrix :=
[ [ 1, 3, 2, 4, 6, 5, 15, 14, 13, 18, 17, 16, 9, 8, 7, 12, 11, 10 ], 
  [ 3, 2, 1, 6, 5, 4, 14, 13, 15, 17, 16, 18, 8, 7, 9, 11, 10, 12 ], 
  [ 2, 1, 3, 5, 4, 6, 13, 15, 14, 16, 18, 17, 7, 9, 8, 10, 12, 11 ], 
  [ 1, 3, 2, 4, 6, 5, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7 ], 
  [ 3, 2, 1, 6, 5, 4, 17, 16, 18, 14, 13, 15, 11, 10, 12, 8, 7, 9 ], 
  [ 2, 1, 3, 5, 4, 6, 16, 18, 17, 13, 15, 14, 10, 12, 11, 7, 9, 8 ], 
  [ 13, 15, 14, 16, 18, 17, 7, 9, 8, 10, 12, 11, 1, 3, 2, 4, 6, 5 ], 
  [ 15, 14, 13, 18, 17, 16, 9, 8, 7, 12, 11, 10, 3, 2, 1, 6, 5, 4 ], 
  [ 14, 13, 15, 17, 16, 18, 8, 7, 9, 11, 10, 12, 2, 1, 3, 5, 4, 6 ], 
  [ 16, 18, 17, 13, 15, 14, 7, 9, 8, 10, 12, 11, 4, 6, 5, 1, 3, 2 ], 
  [ 18, 17, 16, 15, 14, 13, 9, 8, 7, 12, 11, 10, 6, 5, 4, 3, 2, 1 ], 
  [ 17, 16, 18, 14, 13, 15, 8, 7, 9, 11, 10, 12, 5, 4, 6, 2, 1, 3 ], 
  [ 8, 7, 9, 11, 10, 12, 2, 1, 3, 5, 4, 6, 13, 15, 14, 16, 18, 17 ], 
  [ 7, 9, 8, 10, 12, 11, 1, 3, 2, 4, 6, 5, 15, 14, 13, 18, 17, 16 ], 
  [ 9, 8, 7, 12, 11, 10, 3, 2, 1, 6, 5, 4, 14, 13, 15, 17, 16, 18 ], 
  [ 11, 10, 12, 8, 7, 9, 5, 4, 6, 2, 1, 3, 13, 15, 14, 16, 18, 17 ], 
  [ 10, 12, 11, 7, 9, 8, 4, 6, 5, 1, 3, 2, 15, 14, 13, 18, 17, 16 ], 
  [ 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 14, 13, 15, 17, 16, 18 ] ]);
QUANDLES[18].implemented := 3;
QUANDLES[18].rack[3] := rec( size := 18, matrix :=
[ [ 1, 3, 2, 4, 6, 5, 18, 17, 16, 15, 14, 13, 9, 8, 7, 12, 11, 10 ], 
  [ 3, 2, 1, 6, 5, 4, 17, 16, 18, 14, 13, 15, 8, 7, 9, 11, 10, 12 ], 
  [ 2, 1, 3, 5, 4, 6, 16, 18, 17, 13, 15, 14, 7, 9, 8, 10, 12, 11 ], 
  [ 1, 3, 2, 4, 6, 5, 15, 14, 13, 18, 17, 16, 12, 11, 10, 9, 8, 7 ], 
  [ 3, 2, 1, 6, 5, 4, 14, 13, 15, 17, 16, 18, 11, 10, 12, 8, 7, 9 ], 
  [ 2, 1, 3, 5, 4, 6, 13, 15, 14, 16, 18, 17, 10, 12, 11, 7, 9, 8 ], 
  [ 13, 15, 14, 16, 18, 17, 7, 9, 8, 10, 12, 11, 4, 6, 5, 1, 3, 2 ], 
  [ 15, 14, 13, 18, 17, 16, 9, 8, 7, 12, 11, 10, 6, 5, 4, 3, 2, 1 ], 
  [ 14, 13, 15, 17, 16, 18, 8, 7, 9, 11, 10, 12, 5, 4, 6, 2, 1, 3 ], 
  [ 16, 18, 17, 13, 15, 14, 7, 9, 8, 10, 12, 11, 1, 3, 2, 4, 6, 5 ], 
  [ 18, 17, 16, 15, 14, 13, 9, 8, 7, 12, 11, 10, 3, 2, 1, 6, 5, 4 ], 
  [ 17, 16, 18, 14, 13, 15, 8, 7, 9, 11, 10, 12, 2, 1, 3, 5, 4, 6 ], 
  [ 11, 10, 12, 8, 7, 9, 2, 1, 3, 5, 4, 6, 13, 15, 14, 16, 18, 17 ], 
  [ 10, 12, 11, 7, 9, 8, 1, 3, 2, 4, 6, 5, 15, 14, 13, 18, 17, 16 ], 
  [ 12, 11, 10, 9, 8, 7, 3, 2, 1, 6, 5, 4, 14, 13, 15, 17, 16, 18 ], 
  [ 8, 7, 9, 11, 10, 12, 5, 4, 6, 2, 1, 3, 13, 15, 14, 16, 18, 17 ], 
  [ 7, 9, 8, 10, 12, 11, 4, 6, 5, 1, 3, 2, 15, 14, 13, 18, 17, 16 ], 
  [ 9, 8, 7, 12, 11, 10, 6, 5, 4, 3, 2, 1, 14, 13, 15, 17, 16, 18 ] ]);
QUANDLES[18].implemented := 4;
QUANDLES[18].rack[4] := rec( size := 18, matrix :=
[ [ 1, 3, 2, 4, 6, 5, 16, 18, 17, 13, 15, 14, 7, 9, 8, 10, 12, 11 ], 
  [ 3, 2, 1, 6, 5, 4, 18, 17, 16, 15, 14, 13, 9, 8, 7, 12, 11, 10 ], 
  [ 2, 1, 3, 5, 4, 6, 17, 16, 18, 14, 13, 15, 8, 7, 9, 11, 10, 12 ], 
  [ 1, 3, 2, 4, 6, 5, 13, 15, 14, 16, 18, 17, 10, 12, 11, 7, 9, 8 ], 
  [ 3, 2, 1, 6, 5, 4, 15, 14, 13, 18, 17, 16, 12, 11, 10, 9, 8, 7 ], 
  [ 2, 1, 3, 5, 4, 6, 14, 13, 15, 17, 16, 18, 11, 10, 12, 8, 7, 9 ], 
  [ 13, 15, 14, 16, 18, 17, 7, 9, 8, 10, 12, 11, 4, 6, 5, 1, 3, 2 ], 
  [ 15, 14, 13, 18, 17, 16, 9, 8, 7, 12, 11, 10, 6, 5, 4, 3, 2, 1 ], 
  [ 14, 13, 15, 17, 16, 18, 8, 7, 9, 11, 10, 12, 5, 4, 6, 2, 1, 3 ], 
  [ 16, 18, 17, 13, 15, 14, 7, 9, 8, 10, 12, 11, 1, 3, 2, 4, 6, 5 ], 
  [ 18, 17, 16, 15, 14, 13, 9, 8, 7, 12, 11, 10, 3, 2, 1, 6, 5, 4 ], 
  [ 17, 16, 18, 14, 13, 15, 8, 7, 9, 11, 10, 12, 2, 1, 3, 5, 4, 6 ], 
  [ 10, 12, 11, 7, 9, 8, 1, 3, 2, 4, 6, 5, 13, 15, 14, 16, 18, 17 ], 
  [ 12, 11, 10, 9, 8, 7, 3, 2, 1, 6, 5, 4, 15, 14, 13, 18, 17, 16 ], 
  [ 11, 10, 12, 8, 7, 9, 2, 1, 3, 5, 4, 6, 14, 13, 15, 17, 16, 18 ], 
  [ 7, 9, 8, 10, 12, 11, 4, 6, 5, 1, 3, 2, 13, 15, 14, 16, 18, 17 ], 
  [ 9, 8, 7, 12, 11, 10, 6, 5, 4, 3, 2, 1, 15, 14, 13, 18, 17, 16 ], 
  [ 8, 7, 9, 11, 10, 12, 5, 4, 6, 2, 1, 3, 14, 13, 15, 17, 16, 18 ] ]);
QUANDLES[18].implemented := 5;
QUANDLES[18].rack[5] := rec( size := 18, matrix :=
[ [ 1, 2, 14, 13, 8, 7, 10, 9, 4, 3, 16, 15, 18, 17, 12, 11, 5, 6 ], 
  [ 1, 2, 13, 14, 7, 8, 9, 10, 3, 4, 16, 15, 17, 18, 12, 11, 6, 5 ], 
  [ 10, 9, 3, 4, 15, 16, 17, 18, 11, 12, 5, 6, 2, 1, 14, 13, 7, 8 ], 
  [ 9, 10, 3, 4, 16, 15, 17, 18, 12, 11, 6, 5, 1, 2, 13, 14, 7, 8 ], 
  [ 17, 18, 11, 12, 5, 6, 2, 1, 14, 13, 7, 8, 10, 9, 3, 4, 15, 16 ], 
  [ 18, 17, 12, 11, 5, 6, 1, 2, 14, 13, 8, 7, 10, 9, 4, 3, 16, 15 ], 
  [ 6, 5, 18, 17, 11, 12, 7, 8, 2, 1, 14, 13, 16, 15, 10, 9, 4, 3 ], 
  [ 5, 6, 18, 17, 12, 11, 7, 8, 1, 2, 13, 14, 15, 16, 9, 10, 4, 3 ], 
  [ 8, 7, 2, 1, 13, 14, 16, 15, 9, 10, 3, 4, 5, 6, 17, 18, 11, 12 ], 
  [ 7, 8, 1, 2, 13, 14, 15, 16, 9, 10, 4, 3, 5, 6, 18, 17, 12, 11 ], 
  [ 16, 15, 9, 10, 3, 4, 5, 6, 17, 18, 11, 12, 8, 7, 2, 1, 13, 14 ], 
  [ 16, 15, 10, 9, 4, 3, 6, 5, 18, 17, 11, 12, 7, 8, 2, 1, 14, 13 ], 
  [ 4, 3, 16, 15, 10, 9, 12, 11, 6, 5, 17, 18, 13, 14, 8, 7, 2, 1 ], 
  [ 3, 4, 15, 16, 10, 9, 11, 12, 6, 5, 18, 17, 13, 14, 7, 8, 1, 2 ], 
  [ 11, 12, 5, 6, 17, 18, 14, 13, 8, 7, 1, 2, 4, 3, 15, 16, 9, 10 ], 
  [ 11, 12, 6, 5, 18, 17, 13, 14, 7, 8, 1, 2, 3, 4, 15, 16, 10, 9 ], 
  [ 14, 13, 8, 7, 1, 2, 4, 3, 15, 16, 9, 10, 11, 12, 5, 6, 17, 18 ], 
  [ 13, 14, 8, 7, 2, 1, 4, 3, 16, 15, 10, 9, 12, 11, 6, 5, 17, 18 ] ]);
QUANDLES[18].implemented := 6;
QUANDLES[18].rack[6] := rec( size := 18, matrix :=
[ [ 1, 3, 2, 6, 5, 4, 17, 16, 18, 14, 13, 15, 9, 8, 7, 11, 10, 12 ], 
  [ 3, 2, 1, 5, 4, 6, 16, 18, 17, 13, 15, 14, 8, 7, 9, 10, 12, 11 ], 
  [ 2, 1, 3, 4, 6, 5, 18, 17, 16, 15, 14, 13, 7, 9, 8, 12, 11, 10 ], 
  [ 2, 1, 3, 4, 6, 5, 14, 13, 15, 16, 18, 17, 11, 10, 12, 8, 7, 9 ], 
  [ 1, 3, 2, 6, 5, 4, 13, 15, 14, 18, 17, 16, 10, 12, 11, 7, 9, 8 ], 
  [ 3, 2, 1, 5, 4, 6, 15, 14, 13, 17, 16, 18, 12, 11, 10, 9, 8, 7 ], 
  [ 14, 13, 15, 16, 18, 17, 7, 9, 8, 12, 11, 10, 4, 6, 5, 1, 3, 2 ], 
  [ 13, 15, 14, 18, 17, 16, 9, 8, 7, 11, 10, 12, 6, 5, 4, 3, 2, 1 ], 
  [ 15, 14, 13, 17, 16, 18, 8, 7, 9, 10, 12, 11, 5, 4, 6, 2, 1, 3 ], 
  [ 16, 18, 17, 13, 15, 14, 8, 7, 9, 10, 12, 11, 1, 3, 2, 6, 5, 4 ], 
  [ 18, 17, 16, 15, 14, 13, 7, 9, 8, 12, 11, 10, 3, 2, 1, 5, 4, 6 ], 
  [ 17, 16, 18, 14, 13, 15, 9, 8, 7, 11, 10, 12, 2, 1, 3, 4, 6, 5 ], 
  [ 12, 11, 10, 9, 8, 7, 1, 3, 2, 6, 5, 4, 13, 15, 14, 18, 17, 16 ], 
  [ 11, 10, 12, 8, 7, 9, 3, 2, 1, 5, 4, 6, 15, 14, 13, 17, 16, 18 ], 
  [ 10, 12, 11, 7, 9, 8, 2, 1, 3, 4, 6, 5, 14, 13, 15, 16, 18, 17 ], 
  [ 9, 8, 7, 11, 10, 12, 6, 5, 4, 3, 2, 1, 14, 13, 15, 16, 18, 17 ], 
  [ 8, 7, 9, 10, 12, 11, 5, 4, 6, 2, 1, 3, 13, 15, 14, 18, 17, 16 ], 
  [ 7, 9, 8, 12, 11, 10, 4, 6, 5, 1, 3, 2, 15, 14, 13, 17, 16, 18 ] ]);
QUANDLES[18].implemented := 7;
QUANDLES[18].rack[7] := rec( size := 18, matrix :=
[ [ 1, 3, 2, 6, 5, 4, 16, 18, 17, 13, 15, 14, 7, 9, 8, 12, 11, 10 ], 
  [ 3, 2, 1, 5, 4, 6, 18, 17, 16, 15, 14, 13, 9, 8, 7, 11, 10, 12 ], 
  [ 2, 1, 3, 4, 6, 5, 17, 16, 18, 14, 13, 15, 8, 7, 9, 10, 12, 11 ], 
  [ 2, 1, 3, 4, 6, 5, 13, 15, 14, 18, 17, 16, 12, 11, 10, 9, 8, 7 ], 
  [ 1, 3, 2, 6, 5, 4, 15, 14, 13, 17, 16, 18, 11, 10, 12, 8, 7, 9 ], 
  [ 3, 2, 1, 5, 4, 6, 14, 13, 15, 16, 18, 17, 10, 12, 11, 7, 9, 8 ], 
  [ 15, 14, 13, 17, 16, 18, 7, 9, 8, 12, 11, 10, 6, 5, 4, 3, 2, 1 ], 
  [ 14, 13, 15, 16, 18, 17, 9, 8, 7, 11, 10, 12, 5, 4, 6, 2, 1, 3 ], 
  [ 13, 15, 14, 18, 17, 16, 8, 7, 9, 10, 12, 11, 4, 6, 5, 1, 3, 2 ], 
  [ 17, 16, 18, 14, 13, 15, 8, 7, 9, 10, 12, 11, 3, 2, 1, 5, 4, 6 ], 
  [ 16, 18, 17, 13, 15, 14, 7, 9, 8, 12, 11, 10, 2, 1, 3, 4, 6, 5 ], 
  [ 18, 17, 16, 15, 14, 13, 9, 8, 7, 11, 10, 12, 1, 3, 2, 6, 5, 4 ], 
  [ 11, 10, 12, 8, 7, 9, 2, 1, 3, 4, 6, 5, 13, 15, 14, 18, 17, 16 ], 
  [ 10, 12, 11, 7, 9, 8, 1, 3, 2, 6, 5, 4, 15, 14, 13, 17, 16, 18 ], 
  [ 12, 11, 10, 9, 8, 7, 3, 2, 1, 5, 4, 6, 14, 13, 15, 16, 18, 17 ], 
  [ 8, 7, 9, 10, 12, 11, 4, 6, 5, 1, 3, 2, 14, 13, 15, 16, 18, 17 ], 
  [ 7, 9, 8, 12, 11, 10, 6, 5, 4, 3, 2, 1, 13, 15, 14, 18, 17, 16 ], 
  [ 9, 8, 7, 11, 10, 12, 5, 4, 6, 2, 1, 3, 15, 14, 13, 17, 16, 18 ] ]);
QUANDLES[18].implemented := 8;
QUANDLES[18].rack[8] := rec( size := 18, matrix :=
[ [ 1, 3, 2, 4, 6, 5, 14, 13, 15, 17, 16, 18, 9, 8, 7, 12, 11, 10 ], 
  [ 3, 2, 1, 6, 5, 4, 13, 15, 14, 16, 18, 17, 8, 7, 9, 11, 10, 12 ], 
  [ 2, 1, 3, 5, 4, 6, 15, 14, 13, 18, 17, 16, 7, 9, 8, 10, 12, 11 ], 
  [ 1, 3, 2, 4, 6, 5, 17, 16, 18, 14, 13, 15, 12, 11, 10, 9, 8, 7 ], 
  [ 3, 2, 1, 6, 5, 4, 16, 18, 17, 13, 15, 14, 11, 10, 12, 8, 7, 9 ], 
  [ 2, 1, 3, 5, 4, 6, 18, 17, 16, 15, 14, 13, 10, 12, 11, 7, 9, 8 ], 
  [ 15, 14, 13, 18, 17, 16, 7, 9, 8, 10, 12, 11, 2, 1, 3, 5, 4, 6 ], 
  [ 14, 13, 15, 17, 16, 18, 9, 8, 7, 12, 11, 10, 1, 3, 2, 4, 6, 5 ], 
  [ 13, 15, 14, 16, 18, 17, 8, 7, 9, 11, 10, 12, 3, 2, 1, 6, 5, 4 ], 
  [ 18, 17, 16, 15, 14, 13, 7, 9, 8, 10, 12, 11, 5, 4, 6, 2, 1, 3 ], 
  [ 17, 16, 18, 14, 13, 15, 9, 8, 7, 12, 11, 10, 4, 6, 5, 1, 3, 2 ], 
  [ 16, 18, 17, 13, 15, 14, 8, 7, 9, 11, 10, 12, 6, 5, 4, 3, 2, 1 ], 
  [ 8, 7, 9, 11, 10, 12, 3, 2, 1, 6, 5, 4, 13, 15, 14, 16, 18, 17 ], 
  [ 7, 9, 8, 10, 12, 11, 2, 1, 3, 5, 4, 6, 15, 14, 13, 18, 17, 16 ], 
  [ 9, 8, 7, 12, 11, 10, 1, 3, 2, 4, 6, 5, 14, 13, 15, 17, 16, 18 ], 
  [ 11, 10, 12, 8, 7, 9, 6, 5, 4, 3, 2, 1, 13, 15, 14, 16, 18, 17 ], 
  [ 10, 12, 11, 7, 9, 8, 5, 4, 6, 2, 1, 3, 15, 14, 13, 18, 17, 16 ], 
  [ 12, 11, 10, 9, 8, 7, 4, 6, 5, 1, 3, 2, 14, 13, 15, 17, 16, 18 ] ]);
QUANDLES[18].implemented := 9;
QUANDLES[18].rack[9] := rec( size := 18, matrix :=
[ [ 1, 3, 2, 6, 5, 4, 16, 18, 17, 13, 15, 14, 11, 10, 12, 8, 7, 9 ], 
  [ 3, 2, 1, 5, 4, 6, 18, 17, 16, 15, 14, 13, 10, 12, 11, 7, 9, 8 ], 
  [ 2, 1, 3, 4, 6, 5, 17, 16, 18, 14, 13, 15, 12, 11, 10, 9, 8, 7 ], 
  [ 2, 1, 3, 4, 6, 5, 13, 15, 14, 18, 17, 16, 8, 7, 9, 10, 12, 11 ], 
  [ 1, 3, 2, 6, 5, 4, 15, 14, 13, 17, 16, 18, 7, 9, 8, 12, 11, 10 ], 
  [ 3, 2, 1, 5, 4, 6, 14, 13, 15, 16, 18, 17, 9, 8, 7, 11, 10, 12 ], 
  [ 16, 18, 17, 13, 15, 14, 7, 9, 8, 12, 11, 10, 6, 5, 4, 3, 2, 1 ], 
  [ 18, 17, 16, 15, 14, 13, 9, 8, 7, 11, 10, 12, 5, 4, 6, 2, 1, 3 ], 
  [ 17, 16, 18, 14, 13, 15, 8, 7, 9, 10, 12, 11, 4, 6, 5, 1, 3, 2 ], 
  [ 13, 15, 14, 18, 17, 16, 8, 7, 9, 10, 12, 11, 3, 2, 1, 5, 4, 6 ], 
  [ 15, 14, 13, 17, 16, 18, 7, 9, 8, 12, 11, 10, 2, 1, 3, 4, 6, 5 ], 
  [ 14, 13, 15, 16, 18, 17, 9, 8, 7, 11, 10, 12, 1, 3, 2, 6, 5, 4 ], 
  [ 11, 10, 12, 8, 7, 9, 6, 5, 4, 3, 2, 1, 13, 15, 14, 18, 17, 16 ], 
  [ 10, 12, 11, 7, 9, 8, 5, 4, 6, 2, 1, 3, 15, 14, 13, 17, 16, 18 ], 
  [ 12, 11, 10, 9, 8, 7, 4, 6, 5, 1, 3, 2, 14, 13, 15, 16, 18, 17 ], 
  [ 8, 7, 9, 10, 12, 11, 3, 2, 1, 5, 4, 6, 14, 13, 15, 16, 18, 17 ], 
  [ 7, 9, 8, 12, 11, 10, 2, 1, 3, 4, 6, 5, 13, 15, 14, 18, 17, 16 ], 
  [ 9, 8, 7, 11, 10, 12, 1, 3, 2, 6, 5, 4, 15, 14, 13, 17, 16, 18 ] ]);
QUANDLES[18].implemented := 10;
QUANDLES[18].rack[10] := rec( size := 18, matrix :=
[ [ 1, 3, 2, 6, 5, 4, 13, 15, 14, 18, 17, 16, 9, 8, 7, 11, 10, 12 ], 
  [ 3, 2, 1, 5, 4, 6, 15, 14, 13, 17, 16, 18, 8, 7, 9, 10, 12, 11 ], 
  [ 2, 1, 3, 4, 6, 5, 14, 13, 15, 16, 18, 17, 7, 9, 8, 12, 11, 10 ], 
  [ 2, 1, 3, 4, 6, 5, 18, 17, 16, 15, 14, 13, 11, 10, 12, 8, 7, 9 ], 
  [ 1, 3, 2, 6, 5, 4, 17, 16, 18, 14, 13, 15, 10, 12, 11, 7, 9, 8 ], 
  [ 3, 2, 1, 5, 4, 6, 16, 18, 17, 13, 15, 14, 12, 11, 10, 9, 8, 7 ], 
  [ 14, 13, 15, 16, 18, 17, 7, 9, 8, 12, 11, 10, 3, 2, 1, 5, 4, 6 ], 
  [ 13, 15, 14, 18, 17, 16, 9, 8, 7, 11, 10, 12, 2, 1, 3, 4, 6, 5 ], 
  [ 15, 14, 13, 17, 16, 18, 8, 7, 9, 10, 12, 11, 1, 3, 2, 6, 5, 4 ], 
  [ 16, 18, 17, 13, 15, 14, 8, 7, 9, 10, 12, 11, 5, 4, 6, 2, 1, 3 ], 
  [ 18, 17, 16, 15, 14, 13, 7, 9, 8, 12, 11, 10, 4, 6, 5, 1, 3, 2 ], 
  [ 17, 16, 18, 14, 13, 15, 9, 8, 7, 11, 10, 12, 6, 5, 4, 3, 2, 1 ], 
  [ 8, 7, 9, 10, 12, 11, 1, 3, 2, 6, 5, 4, 13, 15, 14, 18, 17, 16 ], 
  [ 7, 9, 8, 12, 11, 10, 3, 2, 1, 5, 4, 6, 15, 14, 13, 17, 16, 18 ], 
  [ 9, 8, 7, 11, 10, 12, 2, 1, 3, 4, 6, 5, 14, 13, 15, 16, 18, 17 ], 
  [ 10, 12, 11, 7, 9, 8, 6, 5, 4, 3, 2, 1, 14, 13, 15, 16, 18, 17 ], 
  [ 12, 11, 10, 9, 8, 7, 5, 4, 6, 2, 1, 3, 13, 15, 14, 18, 17, 16 ], 
  [ 11, 10, 12, 8, 7, 9, 4, 6, 5, 1, 3, 2, 15, 14, 13, 17, 16, 18 ] ]);
QUANDLES[18].implemented := 11;
QUANDLES[18].rack[11] := rec( size := 18, matrix :=
[ [ 1, 3, 2, 4, 5, 6, 17, 16, 18, 15, 13, 14, 12, 10, 11, 9, 8, 7 ], 
  [ 3, 2, 1, 4, 5, 6, 18, 17, 16, 13, 14, 15, 11, 12, 10, 7, 9, 8 ], 
  [ 2, 1, 3, 4, 5, 6, 16, 18, 17, 14, 15, 13, 10, 11, 12, 8, 7, 9 ], 
  [ 1, 2, 3, 4, 6, 5, 14, 15, 13, 18, 17, 16, 8, 9, 7, 11, 10, 12 ], 
  [ 1, 2, 3, 6, 5, 4, 13, 14, 15, 17, 16, 18, 9, 7, 8, 10, 12, 11 ], 
  [ 1, 2, 3, 5, 4, 6, 15, 13, 14, 16, 18, 17, 7, 8, 9, 12, 11, 10 ], 
  [ 18, 16, 17, 15, 14, 13, 7, 9, 8, 10, 11, 12, 5, 4, 6, 3, 1, 2 ], 
  [ 17, 18, 16, 13, 15, 14, 9, 8, 7, 10, 11, 12, 6, 5, 4, 1, 2, 3 ], 
  [ 16, 17, 18, 14, 13, 15, 8, 7, 9, 10, 11, 12, 4, 6, 5, 2, 3, 1 ], 
  [ 14, 15, 13, 17, 16, 18, 7, 8, 9, 10, 12, 11, 2, 3, 1, 6, 5, 4 ], 
  [ 15, 13, 14, 16, 18, 17, 7, 8, 9, 12, 11, 10, 1, 2, 3, 5, 4, 6 ], 
  [ 13, 14, 15, 18, 17, 16, 7, 8, 9, 11, 10, 12, 3, 1, 2, 4, 6, 5 ], 
  [ 11, 10, 12, 9, 7, 8, 6, 4, 5, 3, 2, 1, 13, 15, 14, 16, 17, 18 ], 
  [ 12, 11, 10, 7, 8, 9, 5, 6, 4, 1, 3, 2, 15, 14, 13, 16, 17, 18 ], 
  [ 10, 12, 11, 8, 9, 7, 4, 5, 6, 2, 1, 3, 14, 13, 15, 16, 17, 18 ], 
  [ 8, 9, 7, 12, 11, 10, 2, 3, 1, 5, 4, 6, 13, 14, 15, 16, 18, 17 ], 
  [ 7, 8, 9, 11, 10, 12, 3, 1, 2, 4, 6, 5, 13, 14, 15, 18, 17, 16 ], 
  [ 9, 7, 8, 10, 12, 11, 1, 2, 3, 6, 5, 4, 13, 14, 15, 17, 16, 18 ] ]);
QUANDLES[18].implemented := 12;
QUANDLES[18].rack[12] := rec( size := 18, matrix :=
[ [ 1, 3, 2, 4, 5, 6, 16, 18, 17, 13, 14, 15, 10, 11, 12, 7, 9, 8 ], 
  [ 3, 2, 1, 4, 5, 6, 17, 16, 18, 14, 15, 13, 12, 10, 11, 8, 7, 9 ], 
  [ 2, 1, 3, 4, 5, 6, 18, 17, 16, 15, 13, 14, 11, 12, 10, 9, 8, 7 ], 
  [ 1, 2, 3, 4, 6, 5, 13, 14, 15, 16, 18, 17, 7, 8, 9, 10, 12, 11 ], 
  [ 1, 2, 3, 6, 5, 4, 15, 13, 14, 18, 17, 16, 8, 9, 7, 12, 11, 10 ], 
  [ 1, 2, 3, 5, 4, 6, 14, 15, 13, 17, 16, 18, 9, 7, 8, 11, 10, 12 ], 
  [ 16, 17, 18, 13, 15, 14, 7, 9, 8, 10, 11, 12, 4, 6, 5, 1, 2, 3 ], 
  [ 18, 16, 17, 14, 13, 15, 9, 8, 7, 10, 11, 12, 5, 4, 6, 2, 3, 1 ], 
  [ 17, 18, 16, 15, 14, 13, 8, 7, 9, 10, 11, 12, 6, 5, 4, 3, 1, 2 ], 
  [ 13, 14, 15, 16, 18, 17, 7, 8, 9, 10, 12, 11, 1, 2, 3, 4, 6, 5 ], 
  [ 14, 15, 13, 18, 17, 16, 7, 8, 9, 12, 11, 10, 3, 1, 2, 6, 5, 4 ], 
  [ 15, 13, 14, 17, 16, 18, 7, 8, 9, 11, 10, 12, 2, 3, 1, 5, 4, 6 ], 
  [ 10, 12, 11, 7, 8, 9, 4, 5, 6, 1, 3, 2, 13, 15, 14, 16, 17, 18 ], 
  [ 11, 10, 12, 8, 9, 7, 6, 4, 5, 2, 1, 3, 15, 14, 13, 16, 17, 18 ], 
  [ 12, 11, 10, 9, 7, 8, 5, 6, 4, 3, 2, 1, 14, 13, 15, 16, 17, 18 ], 
  [ 7, 8, 9, 10, 12, 11, 1, 2, 3, 4, 6, 5, 13, 14, 15, 16, 18, 17 ], 
  [ 9, 7, 8, 12, 11, 10, 2, 3, 1, 6, 5, 4, 13, 14, 15, 18, 17, 16 ], 
  [ 8, 9, 7, 11, 10, 12, 3, 1, 2, 5, 4, 6, 13, 14, 15, 17, 16, 18 ] ]);


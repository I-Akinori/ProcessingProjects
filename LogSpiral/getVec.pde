PVector[] getVector(PVector[] vec) {
  PVector[] nextVec = new PVector[gon];
  for ( int i = 0; i < gon; i++) {
    PVector dir = PVector.sub(vec[(i + 1) % gon], vec[i]);
    dir.mult(gap);
    nextVec[i] = PVector.add(vec[i], dir);
  }
  return(nextVec);
}

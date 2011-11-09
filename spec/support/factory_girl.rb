Factory.define :user, :class=>EydUser do |f|
  f.id 1
  f.name 'tim.tang'
  f.hashed_password 'f154b034cf1e3dad29377e2b4496516889a8c6025cb98c0ef1ac2580497ab6ee'
  f.salt '833156400.9654452857849118'
  f.email 'tang.jilong@139.com'
end

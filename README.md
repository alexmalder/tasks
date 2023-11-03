# videos

## routing

- [ ] add sign in with routing
- [ ] add feed from api homepage
- [ ] add profile details from api
- [ ] add fake settings from api

## how to find tasks

```bash
grep -r "@task" lib | sed 's/.*\/\/ @task //g' | sort
```

Format of the task in comment

```dart
// @task get new list[widget]
^--^-----------------^ tag of the task
^--^ tag of the comment[task]
^ comment
```

## Authors

<vnmntn@mail.ru>

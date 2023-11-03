# videos

## routing

- [ ] add sign in with routing
- [ ] add feed from api homepage
- [ ] add profile details from api
- [ ] add fake settings from api

## how to find tasks

## Comment format

```dart
// @task get new list[widget]
^  ^                 ^ tag of the task
^  ^ tag of the comment[task]
^ comment
```

## Find pipeline

```bash
grep -r "@task" lib | sed 's/.*\/\/ @task /- [ ] /g' | sort
```

## Example

- [ ] need alert when sign-in succeed[widget]
- [ ] need id required parameter[widget]
- [ ] need render list[widget]
- [ ] need sign-in page[screen]
- [ ] test signIn and signUp methods[api calls]
- [ ] test toJson method[model]

## Authors

<vnmntn@mail.ru>

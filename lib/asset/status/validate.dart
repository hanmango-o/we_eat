/// [Validate]는 Input 로직에서의 Validation 상태를 의미합니다.
///
/// 각 상태별 설명은 아래와 같습니다.
/// |[Validate]   |Description                              |
/// |:--------|:----------------------------------------|
/// |`pass`|Validation 통과를 의미|
/// |`error` |Validation 실패를 의미, 넒은 의미에서의 모든 경우의 실패를 의미|
/// |`containSpace` |입력값이 띄어쓰기를 포함하는 경우를 의미|
/// |`maxLength` |입력값이 최대 입력 가능 값을 초과함을 의미|
/// |`minLength` |입력값이 최소 입력 필수 값에 부족함을 의미|
/// |`notContainNumber` |입력값이 숫자를 포함하지 않음을 의미|
/// |`containSpecialChar` |입력값이 특수문자를 포함하는 경우를 의미|
/// |`notMatchPW` |입력값이 기존 PW와 일치하지 않음을 의미|
/// |`uncompliteWord` |입력값이 완성형 한글(ex. 삼, 겹살)이 아님(ex. 삼ㄱ, 겹ㄴ살)을 의미|
enum Validate {
  pass,
  error,
  containSpace,
  maxLength,
  minLength,
  notContainNumber,
  containSpecialChar,
  notMatchPW,
  uncompliteWord,
}

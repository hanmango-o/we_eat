// ignore_for_file: constant_identifier_names

/// [ChatType]은 Websocket에서의 채팅 상태를 의미합니다.
/// Websocket을 통해 아래의 상태에 맞춰 type을 지정해주어야 정상적으로 채팅이 작동합니다.
///
/// 각 채팅의 상태는 아래와 같습니다.
/// |[ChatType]   |Description                              |
/// |:--------|:----------------------------------------|
/// |`ENTER`|채팅방에 입장하는 상태를 의미  |
/// |`TALK` |입장(ENTER)이후, 채팅 입력을 통한 대화 상태를 의미|
/// |`OUT` |채팅방을 완전히 나가는 상태를 의미|
/// |`BACK` |채팅방에서 완전히 나가는 것이 아닌 단순 뒤로가기(나가기) 상태를 의미|
enum ChatType {
  ENTER,
  TALK,
  OUT,
  BACK,
}

package Lv0;

import java.util.Arrays;

/**
 * 머쓱이는 태어난 지 6개월 된 조카를 돌보고 있습니다.
 * 조카는 아직 "aya", "ye", "woo", "ma" 네 가지 발음을 최대 한 번씩 사용해 조합한(이어 붙인) 발음밖에 하지 못합니다.
 * 문자열 배열 babbling이 매개변수로 주어질 때,
 * 머쓱이의 조카가 발음할 수 있는 단어의 개수를 return 하도록 solution 함수를 완성해주세요.
 *
 * 제한사항
 * 1 ≤ babbling의 길이 ≤ 100
 * 1 ≤ babbling[i]의 길이 ≤ 15
 * babbling 의 각 문자열에서 "aya", "ye", "woo", "ma"는 각각 최대 한 번씩만 등장합니다.
 * 즉, 각 문자열의 가능한 모든 부분 문자열 중에서 "aya", "ye", "woo", "ma"가 한 번씩만 등장합니다.
 * 문자열은 알파벳 소문자로만 이루어져 있습니다.
 *
 * 유의사항
 * 네 가지를 붙여 만들 수 있는 발음 이외에는 어떤 발음도 할 수 없는 것으로 규정합니다.
 * 예를 들어 "woowo"는 "woo"는 발음할 수 있지만 "wo"를 발음할 수 없기 때문에 할 수 없는 발음입니다.
 */

public class Babble {

    public int solution(String[] babbling) {
        int answer = 0;
        for (String str : babbling) {
            if (str.contains("ayaaya") || str.contains("yeye") || str.contains("woowoo") || str.contains("mama")) {
                continue;
            }
            String result = str.replaceAll("aya", "").replaceAll("ye", "").
                    replaceAll("woo", "").replaceAll("ma", "");

            if (result.length() == 0) {
                answer++;
            }
        }
        return answer;
    }
}

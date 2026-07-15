using System;
using System.Collections.Generic;
using UnityEngine;

namespace ReCamp.Data
{
    /// <summary>
    /// Code-first roster used until approved character sheets are ready to become authored assets.
    /// Values are intentionally gray-box balance and can later migrate to ScriptableObjects unchanged.
    /// </summary>
    public static class CharacterRoster
    {
        private static readonly CharacterDefinition[] Definitions =
        {
            new(
                CharacterId.Luna,
                "루나",
                "정찰형 근접 딜러",
                "빠르게 폐허를 탐색하고 자원을 회수하는 고양이 후드 정찰병",
                new Color32(105, 229, 190, 255),
                new Color32(245, 235, 208, 255),
                new Color32(244, 139, 178, 255),
                90,
                6.6f,
                7,
                2.7f,
                0.38f,
                "캣 스텝",
                "바라보는 방향으로 짧게 대시한다.",
                4.5f),
            new(
                CharacterId.Miyu,
                "미유",
                "드론 기반 원거리 지속 딜러",
                "사람보다 기계와 대화하는 것이 편한 소형 드론 엔지니어",
                new Color32(169, 133, 220, 255),
                new Color32(108, 116, 130, 255),
                new Color32(65, 194, 255, 255),
                100,
                5.2f,
                6,
                7.5f,
                0.48f,
                "드론 버스트",
                "드론이 가장 가까운 적에게 집중 사격한다.",
                6f),
            new(
                CharacterId.Coco,
                "코코",
                "회복·보호막 서포터",
                "평소에는 부드럽지만 위기 상황에서는 누구보다 단호한 현장 구조요원",
                new Color32(244, 139, 127, 255),
                new Color32(245, 239, 220, 255),
                new Color32(62, 190, 137, 255),
                115,
                5f,
                5,
                5.5f,
                0.72f,
                "리커버리 펄스",
                "잃은 체력 일부를 즉시 회복한다.",
                8f),
            new(
                CharacterId.Iris,
                "이리스",
                "단일 대상·보스전 특화 원거리 딜러",
                "완벽한 한 발을 위해 감정까지 통제하려는 정밀 사격 전문가",
                new Color32(120, 82, 168, 255),
                new Color32(239, 239, 244, 255),
                new Color32(194, 55, 75, 255),
                85,
                4.8f,
                15,
                11f,
                1.3f,
                "포커스 샷",
                "먼 거리의 적 하나에게 강한 정밀 사격을 가한다.",
                7f),
            new(
                CharacterId.Noah,
                "노아",
                "가드·반격·방어막 탱커",
                "캠프의 가장 앞에서 모두를 지키는 전개식 방패 수호자",
                new Color32(43, 60, 91, 255),
                new Color32(127, 143, 154, 255),
                new Color32(234, 166, 55, 255),
                150,
                4.4f,
                9,
                2.9f,
                0.85f,
                "퍼펙트 가드",
                "잠시 받는 피해를 줄이고 첫 피격에 반격한다.",
                9f),
        };

        private static readonly IReadOnlyList<CharacterDefinition> ReadOnlyDefinitions =
            Array.AsReadOnly(Definitions);

        public static IReadOnlyList<CharacterDefinition> All => ReadOnlyDefinitions;
        public static CharacterDefinition Default => Definitions[0];

        public static CharacterDefinition Get(CharacterId id)
        {
            return TryGet(id, out var definition) ? definition : Default;
        }

        public static bool TryGet(CharacterId id, out CharacterDefinition definition)
        {
            var index = (int)id;
            if (index >= 0 && index < Definitions.Length && Definitions[index].Id == id)
            {
                definition = Definitions[index];
                return true;
            }

            definition = null;
            return false;
        }

        public static CharacterDefinition GetPrevious(CharacterId current)
        {
            var index = TryGet(current, out _) ? (int)current : 0;
            index = (index - 1 + Definitions.Length) % Definitions.Length;
            return Definitions[index];
        }

        public static CharacterDefinition GetNext(CharacterId current)
        {
            var index = TryGet(current, out _) ? (int)current : -1;
            index = (index + 1) % Definitions.Length;
            return Definitions[index];
        }
    }
}

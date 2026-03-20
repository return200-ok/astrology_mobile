class OracleSign {
  const OracleSign({
    required this.id,
    required this.name,
    required this.symbol,
    required this.dateRange,
    required this.guidance,
    required this.essence,
    required this.spiritualFlow,
    required this.drawnTo,
    required this.radiatesTo,
    required this.dharmaPath,
    required this.sacredNeeds,
  });

  final String id;
  final String name;
  final String symbol;
  final String dateRange;
  final String guidance;
  final List<String> essence;
  final List<String> spiritualFlow;
  final List<String> drawnTo;
  final List<String> radiatesTo;
  final List<String> dharmaPath;
  final List<String> sacredNeeds;
}

const List<OracleSign> oracleSigns = [
  OracleSign(
    id: 'aries',
    name: 'ARIES',
    symbol: '♈',
    dateRange: 'Mar 21 - Apr 19',
    guidance:
        'CELESTIAL GUIDANCE: Your inner flame is rising. A new path is forming. '
        'Take bold steps and trust your first instinct.',
    essence: ['Born initiator', 'Radiant energy', 'Instinctual', 'Fearless'],
    spiritualFlow: ['Direct and focused', 'Swift intuition', 'Sacred logic'],
    drawnTo: ['Dynamic spirits', 'Inner strength', 'Independent souls'],
    radiatesTo: ['People craving momentum', 'Trailblazers', 'Courage seekers'],
    dharmaPath: ['Pioneer', 'Protector', 'Igniter', 'Leader'],
    sacredNeeds: ['Challenge', 'Autonomy', 'Action'],
  ),
  OracleSign(
    id: 'taurus',
    name: 'TAURUS',
    symbol: '♉',
    dateRange: 'Apr 20 - May 20',
    guidance:
        'CELESTIAL GUIDANCE: Root into stillness. Prosperity grows through '
        'patience and devotion to what truly nourishes your spirit.',
    essence: ['Steady heart', 'Grounded', 'Sensual', 'Reliable'],
    spiritualFlow: ['Consistent progress', 'Earth wisdom', 'Sacred discipline'],
    drawnTo: ['Loyal connections', 'Beauty and craft', 'Soul stability'],
    radiatesTo: ['People needing calm', 'Builders', 'Heart-led creators'],
    dharmaPath: ['Stabilizer', 'Cultivator', 'Guardian', 'Value keeper'],
    sacredNeeds: ['Security', 'Rhythm', 'Beauty'],
  ),
  OracleSign(
    id: 'gemini',
    name: 'GEMINI',
    symbol: '♊',
    dateRange: 'May 21 - Jun 20',
    guidance:
        'CELESTIAL GUIDANCE: Messages are arriving from many realms. Follow '
        'curiosity and let your voice become a bridge of light.',
    essence: ['Adaptable', 'Curious', 'Social', 'Free'],
    spiritualFlow: ['Analytical', 'Quick-witted', 'Versatile'],
    drawnTo: ['Intelligence', 'Diversity', 'Wit'],
    radiatesTo: ['People seeking life', 'Storytellers'],
    dharmaPath: ['Messenger', 'Writer', 'Bridge builder', 'Thinker'],
    sacredNeeds: ['Mental stimulation', 'Expression', 'Space'],
  ),
  OracleSign(
    id: 'cancer',
    name: 'CANCER',
    symbol: '♋',
    dateRange: 'Jun 21 - Jul 22',
    guidance:
        'CELESTIAL GUIDANCE: Your emotional tides carry wisdom. Protect your '
        'softness and let home become a sanctuary for renewal.',
    essence: ['Nurturing core', 'Sensitive', 'Protective', 'Devotional'],
    spiritualFlow: ['Lunar intuition', 'Heart memory', 'Emotional wisdom'],
    drawnTo: ['Soul family', 'Gentle strength', 'Meaningful intimacy'],
    radiatesTo: ['People needing care', 'Children', 'Sacred circles'],
    dharmaPath: ['Healer', 'Keeper of home', 'Emotional guide', 'Moon priestess'],
    sacredNeeds: ['Safety', 'Belonging', 'Emotional honesty'],
  ),
  OracleSign(
    id: 'leo',
    name: 'LEO',
    symbol: '♌',
    dateRange: 'Jul 23 - Aug 22',
    guidance:
        'CELESTIAL GUIDANCE: Stand in your radiance without apology. Your joy '
        'is medicine for others and leadership is awakening.',
    essence: ['Solar charisma', 'Creative fire', 'Noble', 'Warm'],
    spiritualFlow: ['Authentic expression', 'Courageous love', 'Generous spirit'],
    drawnTo: ['Bold creators', 'Loyal allies', 'Celebratory energy'],
    radiatesTo: ['People seeking confidence', 'Artists', 'Communities'],
    dharmaPath: ['Creator', 'Performer', 'Heart leader', 'Inspiration source'],
    sacredNeeds: ['Recognition', 'Play', 'Loyal love'],
  ),
  OracleSign(
    id: 'virgo',
    name: 'VIRGO',
    symbol: '♍',
    dateRange: 'Aug 23 - Sep 22',
    guidance:
        'CELESTIAL GUIDANCE: Refine your rituals and align with purpose. Every '
        'small sacred act becomes a doorway to mastery.',
    essence: ['Discerning', 'Precise', 'Healing', 'Humble'],
    spiritualFlow: ['Structured clarity', 'Mindful service', 'Practical magic'],
    drawnTo: ['Integrity', 'Quiet brilliance', 'Purposeful routines'],
    radiatesTo: ['People needing order', 'Healing spaces', 'Systems'],
    dharmaPath: ['Alchemist of detail', 'Craft master', 'Problem solver', 'Teacher'],
    sacredNeeds: ['Purpose', 'Clean energy', 'Useful contribution'],
  ),
  OracleSign(
    id: 'libra',
    name: 'LIBRA',
    symbol: '♎',
    dateRange: 'Sep 23 - Oct 22',
    guidance:
        'CELESTIAL GUIDANCE: Seek harmony without losing your center. Your '
        'gift is to bring beauty, fairness, and graceful balance.',
    essence: ['Elegant', 'Diplomatic', 'Refined', 'Relational'],
    spiritualFlow: ['Aesthetic intuition', 'Calm mediation', 'Justice sense'],
    drawnTo: ['Mutual respect', 'Artful spaces', 'Soul companionship'],
    radiatesTo: ['People seeking peace', 'Partners', 'Creative teams'],
    dharmaPath: ['Peacemaker', 'Connector', 'Beauty curator', 'Justice bearer'],
    sacredNeeds: ['Balance', 'Partnership', 'Graceful dialogue'],
  ),
  OracleSign(
    id: 'scorpio',
    name: 'SCORPIO',
    symbol: '♏',
    dateRange: 'Oct 23 - Nov 21',
    guidance:
        'CELESTIAL GUIDANCE: Transformation is your sacred terrain. Release old '
        'skins and trust the rebirth that follows deep truth.',
    essence: ['Magnetic', 'Intense', 'Transformative', 'Private'],
    spiritualFlow: ['Fearless introspection', 'Emotional alchemy', 'Focused will'],
    drawnTo: ['Authenticity', 'Mystery', 'Profound devotion'],
    radiatesTo: ['People in transition', 'Truth seekers', 'Deep bonds'],
    dharmaPath: ['Transformer', 'Shadow worker', 'Truth revealer', 'Guardian'],
    sacredNeeds: ['Trust', 'Depth', 'Emotional loyalty'],
  ),
  OracleSign(
    id: 'sagittarius',
    name: 'SAGITTARIUS',
    symbol: '♐',
    dateRange: 'Nov 22 - Dec 21',
    guidance:
        'CELESTIAL GUIDANCE: Expansion calls your name. Follow truth, movement, '
        'and the philosophy that sets your spirit free.',
    essence: ['Visionary', 'Adventurous', 'Optimistic', 'Honest'],
    spiritualFlow: ['Higher learning', 'Spiritual freedom', 'Big-picture faith'],
    drawnTo: ['Open horizons', 'Wise mentors', 'Expansive journeys'],
    radiatesTo: ['People seeking meaning', 'Travelers', 'Students'],
    dharmaPath: ['Explorer', 'Teacher', 'Philosopher', 'Fire messenger'],
    sacredNeeds: ['Freedom', 'Growth', 'Truth'],
  ),
  OracleSign(
    id: 'capricorn',
    name: 'CAPRICORN',
    symbol: '♑',
    dateRange: 'Dec 22 - Jan 19',
    guidance:
        'CELESTIAL GUIDANCE: Build what is timeless. Your discipline is sacred '
        'and your devotion can shape mountains into pathways.',
    essence: ['Disciplined', 'Ambitious', 'Responsible', 'Enduring'],
    spiritualFlow: ['Strategic focus', 'Steady ascent', 'Legacy thinking'],
    drawnTo: ['Reliable allies', 'Long-term vision', 'Meaningful achievement'],
    radiatesTo: ['People needing structure', 'Teams', 'Future builders'],
    dharmaPath: ['Architect', 'Steward', 'Mountain climber', 'Legacy maker'],
    sacredNeeds: ['Respect', 'Mastery', 'Clear goals'],
  ),
  OracleSign(
    id: 'aquarius',
    name: 'AQUARIUS',
    symbol: '♒',
    dateRange: 'Jan 20 - Feb 18',
    guidance:
        'CELESTIAL GUIDANCE: Innovate from the soul. Your ideas arrive from the '
        'future and are meant to liberate collective consciousness.',
    essence: ['Original', 'Independent', 'Visionary', 'Humanitarian'],
    spiritualFlow: ['Detached clarity', 'Inventive insight', 'Collective service'],
    drawnTo: ['Unconventional minds', 'Shared causes', 'Freedom of thought'],
    radiatesTo: ['People seeking change', 'Communities', 'Future thinkers'],
    dharmaPath: ['Reformer', 'Inventor', 'Network weaver', 'Awakener'],
    sacredNeeds: ['Freedom', 'Purposeful community', 'Innovation'],
  ),
  OracleSign(
    id: 'pisces',
    name: 'PISCES',
    symbol: '♓',
    dateRange: 'Feb 19 - Mar 20',
    guidance:
        'CELESTIAL GUIDANCE: Let compassion guide your current. Dreams and '
        'intuition are speaking; soften, listen, and receive.',
    essence: ['Mystic empathy', 'Imaginative', 'Compassionate', 'Fluid'],
    spiritualFlow: ['Dream intelligence', 'Spiritual surrender', 'Subtle healing'],
    drawnTo: ['Tender hearts', 'Artistic souls', 'Spiritual connection'],
    radiatesTo: ['People needing comfort', 'Artists', 'Sacred spaces'],
    dharmaPath: ['Dreamer', 'Healer', 'Poet', 'Mystic channel'],
    sacredNeeds: ['Emotional sanctuary', 'Creative flow', 'Spiritual trust'],
  ),
];

import { getRatingSlug } from '@aiready/core/client';

/**
 * Get the Tailwind color class for a score using core rating system
 */
export function scoreColor(score: number | null | undefined): string {
  if (score == null) return 'text-slate-400';
  const rating = getRatingSlug(score);
  switch (rating) {
    case 'excellent':
    case 'good':
      return 'text-emerald-400';
    case 'fair':
      return 'text-amber-400';
    default:
      return 'text-red-400';
  }
}

/**
 * Get the Tailwind background/border class for a score using core rating system
 */
export function scoreBg(score: number | null | undefined): string {
  if (score == null) return 'bg-slate-800/50 border-slate-700';
  const rating = getRatingSlug(score);
  switch (rating) {
    case 'excellent':
    case 'good':
      return 'bg-emerald-900/30 border-emerald-500/30';
    case 'fair':
      return 'bg-amber-900/30 border-amber-500/30';
    default:
      return 'bg-red-900/30 border-red-500/30';
  }
}

/**
 * Get the display label for a score using core rating system
 */
export function scoreLabel(score: number | null | undefined): string {
  if (score == null) return 'Not analyzed';
  const rating = getRatingSlug(score);
  switch (rating) {
    case 'excellent':
      return 'Excellent';
    case 'good':
      return 'AI-Ready';
    case 'fair':
      return 'Fair';
    case 'needs-work':
      return 'Needs Improvement';
    default:
      return 'Critical Issues';
  }
}

/**
 * Get the Tailwind shadow glow class for a score using core rating system
 */
export function scoreGlow(score: number | null | undefined): string {
  if (score == null) return '';
  const rating = getRatingSlug(score);
  switch (rating) {
    case 'excellent':
    case 'good':
      return 'shadow-emerald-500/20';
    case 'fair':
      return 'shadow-amber-500/20';
    default:
      return 'shadow-red-500/20';
  }
}

/**
 * Get rating from score (for use with ScoreBar component)
 */
export function getScoreRating(
  score: number | null | undefined
): 'excellent' | 'good' | 'fair' | 'needs-work' | 'critical' {
  if (score == null) return 'critical';
  return getRatingSlug(score) as any;
}

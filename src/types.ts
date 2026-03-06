import type {
  ScanOptions,
  AnalysisResult,
  Issue,
  IssueType,
} from '@aiready/core';

export interface ChangeAmplificationOptions extends ScanOptions {}

export interface ChangeAmplificationIssue extends Issue {
  type: IssueType.ChangeAmplification;
}

export interface FileChangeAmplificationResult extends AnalysisResult {
  issues: ChangeAmplificationIssue[];
}

export interface ChangeAmplificationReport {
  summary: {
    totalFiles: number;
    totalIssues: number;
    criticalIssues: number;
    majorIssues: number;
    score: number;
    rating: string;
    recommendations: string[];
  };
  results: FileChangeAmplificationResult[];
}

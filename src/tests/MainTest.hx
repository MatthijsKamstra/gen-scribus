package tests;

import buddy.*;

using buddy.Should;

/**
 *
 * https://github.com/ciscoheat/buddy
 */
@colorize
// Implement "Buddy" and define an array of classes within the brackets:
class MainTest implements Buddy<[
	TestScMarkdownConverter,
	// TestFilename,
	// TestTranslatename,
	// TestRegex,
	// TestTSJsonDef,
	// Tests,
	// path.to.YourBuddySuite,
	// AnotherTestSuite,
	// new SpecialSuite("Constant value", 123)
]> {}

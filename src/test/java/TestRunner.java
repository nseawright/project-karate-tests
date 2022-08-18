import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestRunner {

    @Test
    void runAllFeatures() {
        final Results results = Runner.path("src/test/resources/features")
                .reportDir("target/karate-reports")
                .parallel(4);
        assertEquals(0, results.getFailCount());
    }
}

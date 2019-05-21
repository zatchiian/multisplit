module Multisplit
  module Metadata
    def reload_metadata
      @metadata.clear do
        prev_seg_best if Data.metadata["show-prev-seg-against-best"]
        pos_timesave  if Data.metadata["show-possible-timesave"]
        sum_of_best   if Data.metadata["show-sum-of-best"]
      end
    end

    def prev_seg_best
      prev = @splits.prev_name
      prev_best = @splits.best[prev]
      prev_time = @splits.times[prev]
      best = !(prev_best.nil? || prev_time.nil? || prev_best < prev_time)
      colorized = colorize_delta(prev_best, prev_time, best)
      flow do
        para "Prev. segment:"
        para colorized.first, stroke: colorized.last
      end
    end

    def pos_timesave
      prev = @splits.prev_name
      prev_best = @splits.best[prev]
      prev_comp = @splits.pb[prev]
      diff = prev_best.nil? || prev_comp.nil? ? \
        Data.splits["text-when-empty"] : stringify(prev_comp - prev_best)
      para "Possible timesave: #{diff}"
    end

    def sum_of_best
      para "Sum of best: #{@splits.sum_of_best}"
    end
  end
end